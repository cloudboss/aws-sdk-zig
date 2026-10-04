const IngestPayloadType = @import("ingest_payload_type.zig").IngestPayloadType;

/// The content included directly in the request as one or more payload items.
pub const InlineMemoryContent = struct {
    /// The list of content payload items to ingest.
    payload: []const IngestPayloadType,

    pub const json_field_names = .{
        .payload = "payload",
    };
};
