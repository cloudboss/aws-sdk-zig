/// Recommended instance types for training and inference with a SageMaker
/// algorithm.
pub const SageMakerAlgorithmRecommendation = struct {
    /// The recommended instance type for batch inference.
    recommended_batch_transform_instance_type: []const u8,

    /// The recommended instance type for real-time inference.
    recommended_realtime_inference_instance_type: ?[]const u8 = null,

    /// The recommended instance type for training.
    recommended_training_instance_type: []const u8,

    pub const json_field_names = .{
        .recommended_batch_transform_instance_type = "recommendedBatchTransformInstanceType",
        .recommended_realtime_inference_instance_type = "recommendedRealtimeInferenceInstanceType",
        .recommended_training_instance_type = "recommendedTrainingInstanceType",
    };
};
