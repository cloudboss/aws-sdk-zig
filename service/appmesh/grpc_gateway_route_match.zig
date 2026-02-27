const GatewayRouteHostnameMatch = @import("gateway_route_hostname_match.zig").GatewayRouteHostnameMatch;
const GrpcGatewayRouteMetadata = @import("grpc_gateway_route_metadata.zig").GrpcGatewayRouteMetadata;

/// An object that represents the criteria for determining a request match.
pub const GrpcGatewayRouteMatch = struct {
    /// The gateway route host name to be matched on.
    hostname: ?GatewayRouteHostnameMatch,

    /// The gateway route metadata to be matched on.
    metadata: ?[]const GrpcGatewayRouteMetadata,

    /// The gateway route port to be matched on.
    port: ?i32,

    /// The fully qualified domain name for the service to match from the request.
    service_name: ?[]const u8,

    pub const json_field_names = .{
        .hostname = "hostname",
        .metadata = "metadata",
        .port = "port",
        .service_name = "serviceName",
    };
};
