const RouterInputMetadata = @import("router_input_metadata.zig").RouterInputMetadata;
const RouterInputMessage = @import("router_input_message.zig").RouterInputMessage;

/// Detailed metadata information about a router input source.
pub const RouterInputSourceMetadataDetails = struct {
    /// Metadata information specific to the router input configuration and state.
    router_input_metadata: ?RouterInputMetadata,

    /// Collection of metadata messages associated with the router input source.
    source_metadata_messages: []const RouterInputMessage,

    /// The timestamp when the metadata was last updated.
    timestamp: i64,

    pub const json_field_names = .{
        .router_input_metadata = "RouterInputMetadata",
        .source_metadata_messages = "SourceMetadataMessages",
        .timestamp = "Timestamp",
    };
};
