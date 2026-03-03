/// Output values produced by an optimization job.
pub const OptimizationOutput = struct {
    /// The image that SageMaker recommends that you use to host the optimized model
    /// that you created with an optimization job.
    recommended_inference_image: ?[]const u8 = null,

    pub const json_field_names = .{
        .recommended_inference_image = "RecommendedInferenceImage",
    };
};
