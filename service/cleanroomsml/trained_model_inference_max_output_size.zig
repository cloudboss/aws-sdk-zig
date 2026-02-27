const TrainedModelInferenceMaxOutputSizeUnitType = @import("trained_model_inference_max_output_size_unit_type.zig").TrainedModelInferenceMaxOutputSizeUnitType;

/// Information about the maximum output size for a trained model inference job.
pub const TrainedModelInferenceMaxOutputSize = struct {
    /// The measurement unit to use.
    unit: TrainedModelInferenceMaxOutputSizeUnitType,

    /// The maximum output size value.
    value: f64,

    pub const json_field_names = .{
        .unit = "unit",
        .value = "value",
    };
};
