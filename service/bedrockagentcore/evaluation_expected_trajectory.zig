/// The expected tool call trajectory for trajectory-based evaluation.
pub const EvaluationExpectedTrajectory = struct {
    /// The list of tool names representing the expected tool call sequence.
    tool_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .tool_names = "toolNames",
    };
};
