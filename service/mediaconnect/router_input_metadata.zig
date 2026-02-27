const TransportMediaInfo = @import("transport_media_info.zig").TransportMediaInfo;

/// Metadata information associated with the router input, including stream
/// details and connection state.
pub const RouterInputMetadata = union(enum) {
    transport_stream_media_info: ?TransportMediaInfo,

    pub const json_field_names = .{
        .transport_stream_media_info = "TransportStreamMediaInfo",
    };
};
