/// A content block for ground truth data in evaluation reference inputs.
/// Supports text content for expected responses and assertions.
pub const EvaluationContent = union(enum) {
    /// The text content of the ground truth data. Used for expected response text
    /// and assertion statements.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
