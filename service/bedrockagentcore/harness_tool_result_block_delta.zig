/// A delta update to a tool result content block.
pub const HarnessToolResultBlockDelta = union(enum) {
    /// A JSON tool result delta.
    json: ?[]const u8,
    /// A text tool result delta.
    text: ?[]const u8,

    pub const json_field_names = .{
        .json = "json",
        .text = "text",
    };
};
