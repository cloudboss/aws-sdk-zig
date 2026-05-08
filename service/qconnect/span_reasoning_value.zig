/// Model reasoning and it's internal decision making process
pub const SpanReasoningValue = struct {
    /// The reasoning text content
    value: []const u8,

    pub const json_field_names = .{
        .value = "value",
    };
};
