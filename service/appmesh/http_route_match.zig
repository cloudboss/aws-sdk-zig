const HttpRouteHeader = @import("http_route_header.zig").HttpRouteHeader;
const HttpMethod = @import("http_method.zig").HttpMethod;
const HttpPathMatch = @import("http_path_match.zig").HttpPathMatch;
const HttpQueryParameter = @import("http_query_parameter.zig").HttpQueryParameter;
const HttpScheme = @import("http_scheme.zig").HttpScheme;

/// An object that represents the requirements for a route to match HTTP
/// requests for a
/// virtual router.
pub const HttpRouteMatch = struct {
    /// The client request headers to match on.
    headers: ?[]const HttpRouteHeader,

    /// The client request method to match on. Specify only one.
    method: ?HttpMethod,

    /// The client request path to match on.
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

    /// The client request query parameters to match on.
    query_parameters: ?[]const HttpQueryParameter,

    /// The client request scheme to match on. Specify only one. Applicable only for
    /// HTTP2
    /// routes.
    scheme: ?HttpScheme,

    pub const json_field_names = .{
        .headers = "headers",
        .method = "method",
        .path = "path",
        .port = "port",
        .prefix = "prefix",
        .query_parameters = "queryParameters",
        .scheme = "scheme",
    };
};
