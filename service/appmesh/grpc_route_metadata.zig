const GrpcRouteMetadataMatchMethod = @import("grpc_route_metadata_match_method.zig").GrpcRouteMetadataMatchMethod;

/// An object that represents the match metadata for the route.
pub const GrpcRouteMetadata = struct {
    /// Specify `True` to match anything except the match criteria. The default
    /// value is `False`.
    invert: ?bool = null,

    /// An object that represents the data to match from the request.
    match: ?GrpcRouteMetadataMatchMethod = null,

    /// The name of the route.
    name: []const u8,

    pub const json_field_names = .{
        .invert = "invert",
        .match = "match",
        .name = "name",
    };
};
