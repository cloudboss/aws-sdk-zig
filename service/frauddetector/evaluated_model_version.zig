const ModelVersionEvaluation = @import("model_version_evaluation.zig").ModelVersionEvaluation;

/// The model version evaluated for generating prediction.
pub const EvaluatedModelVersion = struct {
    /// Evaluations generated for the model version.
    evaluations: ?[]const ModelVersionEvaluation,

    /// The model ID.
    model_id: ?[]const u8,

    /// The model type.
    ///
    /// Valid values: `ONLINE_FRAUD_INSIGHTS` | `TRANSACTION_FRAUD_INSIGHTS`
    model_type: ?[]const u8,

    /// The model version.
    model_version: ?[]const u8,

    pub const json_field_names = .{
        .evaluations = "evaluations",
        .model_id = "modelId",
        .model_type = "modelType",
        .model_version = "modelVersion",
    };
};
