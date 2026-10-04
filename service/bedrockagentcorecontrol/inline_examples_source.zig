/// Inline examples provided directly in the request body.
pub const InlineExamplesSource = struct {
    /// Examples to add. Each example is assigned an auto-generated UUID.
    examples: []const []const u8,

    pub const json_field_names = .{
        .examples = "examples",
    };
};
