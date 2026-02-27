const DriftCheckBias = @import("drift_check_bias.zig").DriftCheckBias;
const DriftCheckExplainability = @import("drift_check_explainability.zig").DriftCheckExplainability;
const DriftCheckModelDataQuality = @import("drift_check_model_data_quality.zig").DriftCheckModelDataQuality;
const DriftCheckModelQuality = @import("drift_check_model_quality.zig").DriftCheckModelQuality;

/// Represents the drift check baselines that can be used when the model monitor
/// is set using the model package.
pub const DriftCheckBaselines = struct {
    /// Represents the drift check bias baselines that can be used when the model
    /// monitor is set using the model package.
    bias: ?DriftCheckBias,

    /// Represents the drift check explainability baselines that can be used when
    /// the model monitor is set using the model package.
    explainability: ?DriftCheckExplainability,

    /// Represents the drift check model data quality baselines that can be used
    /// when the model monitor is set using the model package.
    model_data_quality: ?DriftCheckModelDataQuality,

    /// Represents the drift check model quality baselines that can be used when the
    /// model monitor is set using the model package.
    model_quality: ?DriftCheckModelQuality,

    pub const json_field_names = .{
        .bias = "Bias",
        .explainability = "Explainability",
        .model_data_quality = "ModelDataQuality",
        .model_quality = "ModelQuality",
    };
};
