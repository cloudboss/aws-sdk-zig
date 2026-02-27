const HttpGatewayRouteHeader = @import("http_gateway_route_header.zig").HttpGatewayRouteHeader;
const GatewayRouteHostnameMatch = @import("gateway_route_hostname_match.zig").GatewayRouteHostnameMatch;
const HttpMethod = @import("http_method.zig").HttpMethod;
const HttpPathMatch = @import("http_path_match.zig").HttpPathMatch;
const HttpQueryParameter = @import("http_query_parameter.zig").HttpQueryParameter;

/// An object that represents the criteria for determining a request match.
pub const HttpGatewayRouteMatch = struct {
    /// The client request headers to match on.
    headers: ?[]const HttpGatewayRouteHeader,

    /// The host name to match on.
    hostname: ?GatewayRouteHostnameMatch,

    /// The method to match on.
    method: ?HttpMethod,

    /// The path to match on.
    path: ?HttpPathMatch,

    /// The port number to match on.
    port: ?i32,

    /// Specifies the path to match requests with. This parameter must always start
    /// with
    /// `/`, which by itself matches all requests to the virtual service name. You
    /// can also match for path-based routing of requests. For example, if your
    /// virtual service
    /// name is `my-service.local` and you want the route to match requests to
    /// `my-service.local/metrics`, your prefix should be
    /// `/metrics`.
    prefix: ?[]const u8,

    /// The query parameter to match on.
    query_parameters: ?[]const HttpQueryParameter,

    pub const json_field_names = .{
        .headers = "headers",
        .hostname = "hostname",
        .method = "method",
        .path = "path",
        .port = "port",
        .prefix = "prefix",
        .query_parameters = "queryParameters",
    };
};
