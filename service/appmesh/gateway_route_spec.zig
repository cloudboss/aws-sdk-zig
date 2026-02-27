const GrpcGatewayRoute = @import("grpc_gateway_route.zig").GrpcGatewayRoute;
const HttpGatewayRoute = @import("http_gateway_route.zig").HttpGatewayRoute;

/// An object that represents a gateway route specification. Specify one gateway
/// route
/// type.
pub const GatewayRouteSpec = struct {
    /// An object that represents the specification of a gRPC gateway route.
    grpc_route: ?GrpcGatewayRoute,

    /// An object that represents the specification of an HTTP/2 gateway route.
    http_2_route: ?HttpGatewayRoute,

    /// An object that represents the specification of an HTTP gateway route.
    http_route: ?HttpGatewayRoute,

    /// The ordering of the gateway routes spec.
    priority: ?i32,

    pub const json_field_names = .{
        .grpc_route = "grpcRoute",
        .http_2_route = "http2Route",
        .http_route = "httpRoute",
        .priority = "priority",
    };
};
