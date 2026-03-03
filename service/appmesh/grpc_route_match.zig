const GrpcRouteMetadata = @import("grpc_route_metadata.zig").GrpcRouteMetadata;

/// An object that represents the criteria for determining a request match.
pub const GrpcRouteMatch = struct {
    /// An object that represents the data to match from the request.
    metadata: ?[]const GrpcRouteMetadata = null,

    /// The method name to match from the request. If you specify a name, you must
    /// also specify
    /// a `serviceName`.
    method_name: ?[]const u8 = null,

    /// The port number to match on.
    port: ?i32 = null,

    /// The fully qualified domain name for the service to match from the request.
    service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata = "metadata",
        .method_name = "methodName",
        .port = "port",
        .service_name = "serviceName",
    };
};
