/// An event in which the prompt was analyzed in preparation for optimization.
pub const AnalyzePromptEvent = struct {
    /// A message describing the analysis of the prompt.
    message: ?[]const u8,

    pub const json_field_names = .{
        .message = "message",
    };
};
