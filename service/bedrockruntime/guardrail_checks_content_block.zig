/// A content block within a message to evaluate.
pub const GuardrailChecksContentBlock = union(enum) {
    /// The text content to evaluate.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
