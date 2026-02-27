/// Represents content input for policy generation operations. This structure
/// encapsulates the natural language descriptions or other content formats that
/// are used as input for AI-powered policy generation.
pub const Content = union(enum) {
    /// The raw text content containing natural language descriptions of desired
    /// policy behavior. This text is processed by AI to generate corresponding
    /// Cedar policy statements that match the described intent.
    raw_text: ?[]const u8,

    pub const json_field_names = .{
        .raw_text = "rawText",
    };
};
