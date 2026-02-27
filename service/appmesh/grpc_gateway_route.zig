const GrpcGatewayRouteAction = @import("grpc_gateway_route_action.zig").GrpcGatewayRouteAction;
const GrpcGatewayRouteMatch = @import("grpc_gateway_route_match.zig").GrpcGatewayRouteMatch;

/// An object that represents a gRPC gateway route.
pub const GrpcGatewayRoute = struct {
    /// An object that represents the action to take if a match is determined.
    action: GrpcGatewayRouteAction,

    /// An object that represents the criteria for determining a request match.
    match: GrpcGatewayRouteMatch,

    pub const json_field_names = .{
        .action = "action",
        .match = "match",
    };
};
