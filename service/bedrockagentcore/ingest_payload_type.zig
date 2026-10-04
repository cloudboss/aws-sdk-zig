const Conversational = @import("conversational.zig").Conversational;
const MemoryJsonData = @import("memory_json_data.zig").MemoryJsonData;

/// A single content payload item to ingest. A payload item contains either
/// conversational or JSON content.
pub const IngestPayloadType = union(enum) {
    /// The conversational content for this payload item.
    conversational: ?Conversational,
    /// The JSON content for this payload item.
    json: ?MemoryJsonData,

    pub const json_field_names = .{
        .conversational = "conversational",
        .json = "json",
    };
};
