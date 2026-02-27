const GrpcMetadataMatchMethod = @import("grpc_metadata_match_method.zig").GrpcMetadataMatchMethod;

/// An object representing the metadata of the gateway route.
pub const GrpcGatewayRouteMetadata = struct {
    /// Specify `True` to match anything except the match criteria. The default
    /// value
    /// is `False`.
    invert: ?bool,

    /// The criteria for determining a metadata match.
    match: ?GrpcMetadataMatchMethod,

    /// A name for the gateway route metadata.
    name: []const u8,

    pub const json_field_names = .{
        .invert = "invert",
        .match = "match",
        .name = "name",
    };
};
