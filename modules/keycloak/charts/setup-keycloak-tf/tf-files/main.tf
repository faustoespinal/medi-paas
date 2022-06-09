terraform {
  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = "3.8.1"
    }
  }
}

provider "keycloak" {
  # Configuration options
  client_id = "admin-cli"
  username  = "admin"
  password  = "karofita55"
  url       = "http://md-keycloak.md-security"
}

locals {
  client_orgs = distinct(flatten([
    for org in var.organizations : [
      for client in var.clients : {
        org_name = org.name
        org_id   = org.id
        client_name = client.name
        client_secret = client.secret
        redirect_url= client.redirect_url
      }
    ]
  ]))

  roles_client_orgs = distinct(flatten([
    for org in var.organizations : [
      for client in var.clients : [
        for role in client.roles : {
          org_name = org.name
          org_id   = org.id
          client_name = client.name
          role_name = role.name
          role_level= role.level
          role_key= format("%s.%s.%s",org.name,client.name,role.name)
        }
      ]
    ]
  ]))

  group_orgs = distinct(flatten([
    for org in var.organizations : [
      for group in org.groups : {
        org_name = org.name
        org_id   = org.id
        group_name = group.name
        group_clients = group.clients
      }
    ]
  ]))

  # Map client names directly to the list of role-names they possess.
  clientroles_map = { for client in var.clients: client.name => [for role in client.roles : role.name] }

  user_orgs = distinct(flatten([
    for org in var.organizations : [
      for user in org.users : {
        org_name = org.name
        org_id   = org.id
        user_name = user.name
        user_lastname = user.lastname
        user_username = user.username
        user_password = user.password
        user_groups   = user.groups
      }
    ]
  ]))

  usergrp_orgs = distinct(flatten([
    for org in var.organizations : [
      for user in org.users : [
        for group in user.groups : {
          org_name = org.name
          org_id   = org.id
          group_key= format("%s.%s",org.name,group)
          user_username = user.username
          group_name= group
        }
      ]
    ]
  ]))  
}

resource "keycloak_realm" "realm" {
  for_each      = { for entry in var.organizations: "${entry.id}" => entry }

  realm             = each.value.id
  enabled           = true
  display_name      =each.value.name
  display_name_html = each.value.name

  login_theme = "base"
}

resource "keycloak_openid_client" "client" {
  for_each      = { for entry in local.client_orgs: "${entry.org_name}.${entry.client_name}" => entry }

  realm_id  = keycloak_realm.realm[each.value.org_id].id
  client_id = each.value.client_name
  client_secret = each.value.client_secret
  name    = each.value.client_name
  enabled = true
  login_theme = "keycloak"

  access_type         = "CONFIDENTIAL"
  standard_flow_enabled = true
  valid_redirect_uris = [
    format("https://%s.karofa:30443/*",each.value.client_name)
  ]
  web_origins = [
    format("https://%s.karofa:30443",each.value.client_name)
  ]
}

# Create all the client roles
resource "keycloak_role" "client_role" {
  for_each      = { for entry in local.roles_client_orgs: "${entry.org_name}.${entry.client_name}.${entry.role_name}" => entry }

  realm_id    = keycloak_realm.realm[each.value.org_id].id
  client_id   = keycloak_openid_client.client[format("%s.%s",each.value.org_name,each.value.client_name)].id
  name        = each.value.role_name
  description = format("%s client role",each.value.role_name)
}

resource "keycloak_group" "group" {
  for_each      = { for entry in local.group_orgs: "${entry.org_name}.${entry.group_name}" => entry }

  realm_id = keycloak_realm.realm[each.value.org_id].id
  name     = each.value.group_name
}

resource "keycloak_group_roles" "group_roles" {
  for_each      = { for entry in local.group_orgs: "${entry.org_name}.${entry.group_name}" => entry }

  realm_id = keycloak_realm.realm[each.value.org_id].id
  group_id = keycloak_group.group[format("%s.%s",each.value.org_name,each.value.group_name)].id

  role_ids = distinct(flatten([
      for client in each.value.group_clients : [
          for role_name in local.clientroles_map[client] : keycloak_role.client_role[format("%s.%s.%s",each.value.org_name,client,role_name)].id
      ]
    ]))
}

resource "keycloak_user" "user" {
  for_each      = { for entry in local.user_orgs: "${entry.org_name}.${entry.user_name}" => entry }

  realm_id = keycloak_realm.realm[each.value.org_id].id
  username = each.value.user_username
  enabled  = true
  email    = format("%s@karofa.io",each.value.user_username)
  email_verified = true
  first_name = each.value.user_name
  last_name = each.value.user_lastname

  attributes = {
    foo = "bar"
  }  

  initial_password {
    value=base64decode(each.value.user_password)
    temporary=false
  }
}

resource "keycloak_group_memberships" "group_members" {
  for_each      = { for entry in local.usergrp_orgs: "${entry.org_name}.${entry.user_username}.${entry.group_name}" => entry }

  realm_id = keycloak_realm.realm[each.value.org_id].id
  group_id = keycloak_group.group[each.value.group_key].id

  members  = [
    each.value.user_username
  ]

  depends_on = [ keycloak_user.user, keycloak_group.group ]
}

resource "keycloak_openid_client_scope" "openid_client_scope" {
  for_each      = { for entry in local.client_orgs: "${entry.org_name}.${entry.client_name}" => entry }

  realm_id  = keycloak_realm.realm[each.value.org_id].id

  name                   = format("%s-service",each.value.client_name)
  description            = "When requested, this scope will map a user's group memberships to a claim"
  include_in_token_scope = true
  gui_order              = 1
}

resource "keycloak_openid_audience_protocol_mapper" "audience_mapper" {
  for_each      = { for entry in local.client_orgs: "${entry.org_name}.${entry.client_name}" => entry }

  realm_id  = keycloak_realm.realm[each.value.org_id].id
  client_scope_id = keycloak_openid_client_scope.openid_client_scope[format("%s.%s",each.value.org_name,each.value.client_name)].id
  included_client_audience = each.value.client_name

  name      = format("%s-audience",each.value.client_name)
}

resource "keycloak_openid_client_default_scopes" "client_default_scopes" {
  for_each      = { for entry in local.client_orgs: "${entry.org_name}.${entry.client_name}" => entry }

  realm_id  = keycloak_realm.realm[each.value.org_id].id
  client_id = keycloak_openid_client.client[format("%s.%s",each.value.org_name,each.value.client_name)].id

  default_scopes = [
    "profile",
    "email",
    "roles",
    "web-origins",
    keycloak_openid_client_scope.openid_client_scope[format("%s.%s",each.value.org_name,each.value.client_name)].name,
  ]
}


