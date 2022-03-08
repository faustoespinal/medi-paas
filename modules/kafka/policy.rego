package istio.authz

import input.attributes.request.http as http_request
import input.parsed_path

default allow = true

allow {
    parsed_path[0] == "health"
    http_request.method == "GET"
}

allow {
    parsed_path[0] == "healthz"
    http_request.method == "GET"
}
