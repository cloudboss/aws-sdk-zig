const GrpcRoute = @import("grpc_route.zig").GrpcRoute;
const HttpRoute = @import("http_route.zig").HttpRoute;
const TcpRoute = @import("tcp_route.zig").TcpRoute;

/// An object that represents a route specification. Specify one route type.
pub const RouteSpec = struct {
    /// An object that represents the specification of a gRPC route.
    grpc_route: ?GrpcRoute = null,

    /// An object that represents the specification of an HTTP/2 route.
    http_2_route: ?HttpRoute = null,

    /// An object that represents the specification of an HTTP route.
    http_route: ?HttpRoute = null,

    /// The priority for the route. Routes are matched based on the specified value,
    /// where 0 is
    /// the highest priority.
    priority: ?i32 = null,

    /// An object that represents the specification of a TCP route.
    tcp_route: ?TcpRoute = null,

    pub const json_field_names = .{
        .grpc_route = "grpcRoute",
        .http_2_route = "http2Route",
        .http_route = "httpRoute",
        .priority = "priority",
        .tcp_route = "tcpRoute",
    };
};
