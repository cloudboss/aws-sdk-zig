/// Configuration information about automated evaluations.
pub const AutoEvaluationConfiguration = struct {
    /// Whether automated evaluations are enabled.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
