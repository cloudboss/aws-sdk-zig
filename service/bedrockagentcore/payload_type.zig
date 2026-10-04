const Conversational = @import("conversational.zig").Conversational;
const MemoryJsonData = @import("memory_json_data.zig").MemoryJsonData;

/// Contains the payload content for an event.
pub const PayloadType = union(enum) {
    /// The binary content of the payload.
    blob: ?[]const u8,
    /// The conversational content of the payload.
    conversational: ?Conversational,
    /// The JSON content of the payload. Use this type to store non-conversational,
    /// JSON-formatted data, such as behavioral events, activity logs, or system
    /// events.
    json: ?MemoryJsonData,

    pub const json_field_names = .{
        .blob = "blob",
        .conversational = "conversational",
        .json = "json",
    };
};
