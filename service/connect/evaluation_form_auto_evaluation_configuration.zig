/// The automatic evaluation configuration of an evaluation form.
pub const EvaluationFormAutoEvaluationConfiguration = struct {
    /// When automated evaluation is enabled.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
