/// Recommended instance types for inference with a SageMaker model.
pub const SageMakerModelRecommendation = struct {
    /// The recommended instance type for batch inference.
    recommended_batch_transform_instance_type: []const u8,

    /// The recommended instance type for real-time inference.
    recommended_realtime_inference_instance_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .recommended_batch_transform_instance_type = "recommendedBatchTransformInstanceType",
        .recommended_realtime_inference_instance_type = "recommendedRealtimeInferenceInstanceType",
    };
};
