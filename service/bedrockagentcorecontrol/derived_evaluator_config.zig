const EvaluatorModelConfig = @import("evaluator_model_config.zig").EvaluatorModelConfig;

/// The configuration for a derived evaluator. It reuses an existing evaluator's
/// logic on your own model.
pub const DerivedEvaluatorConfig = struct {
    /// The identifier of the base evaluator whose logic to run (a `Builtin.*` or
    /// `ThirdParty.*` evaluator).
    base_evaluator_id: []const u8,

    /// The configuration of the evaluator model that you supply.
    model_config: EvaluatorModelConfig,

    pub const json_field_names = .{
        .base_evaluator_id = "baseEvaluatorId",
        .model_config = "modelConfig",
    };
};
