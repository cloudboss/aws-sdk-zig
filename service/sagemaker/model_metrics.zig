const Bias = @import("bias.zig").Bias;
const Explainability = @import("explainability.zig").Explainability;
const ModelDataQuality = @import("model_data_quality.zig").ModelDataQuality;
const ModelQuality = @import("model_quality.zig").ModelQuality;

/// Contains metrics captured from a model.
pub const ModelMetrics = struct {
    /// Metrics that measure bias in a model.
    bias: ?Bias = null,

    /// Metrics that help explain a model.
    explainability: ?Explainability = null,

    /// Metrics that measure the quality of the input data for a model.
    model_data_quality: ?ModelDataQuality = null,

    /// Metrics that measure the quality of a model.
    model_quality: ?ModelQuality = null,

    pub const json_field_names = .{
        .bias = "Bias",
        .explainability = "Explainability",
        .model_data_quality = "ModelDataQuality",
        .model_quality = "ModelQuality",
    };
};
