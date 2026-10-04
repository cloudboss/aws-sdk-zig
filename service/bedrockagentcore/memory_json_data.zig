/// Contains non-conversational, JSON-formatted content for an event payload.
/// JSON payloads are extracted into long-term memory.
pub const MemoryJsonData = struct {
    /// The JSON content of the payload. Accepts any JSON value, including objects,
    /// arrays, strings, numbers, booleans, and null. The maximum size is 100 KB.
    content: []const u8,

    pub const json_field_names = .{
        .content = "content",
    };
};
