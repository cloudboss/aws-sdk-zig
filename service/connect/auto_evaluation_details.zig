const AutoEvaluationStatus = @import("auto_evaluation_status.zig").AutoEvaluationStatus;

/// Details about automated evaluations.
pub const AutoEvaluationDetails = struct {
    /// Whether automated evaluation is enabled.
    auto_evaluation_enabled: bool = false,

    /// The status of the contact auto-evaluation.
    auto_evaluation_status: ?AutoEvaluationStatus = null,

    pub const json_field_names = .{
        .auto_evaluation_enabled = "AutoEvaluationEnabled",
        .auto_evaluation_status = "AutoEvaluationStatus",
    };
};
