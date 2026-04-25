const AIRecommendationInstanceDetail = @import("ai_recommendation_instance_detail.zig").AIRecommendationInstanceDetail;

/// Details about the model package in a recommendation.
pub const AIRecommendationModelDetails = struct {
    /// The name of the inference specification within the model package.
    inference_specification_name: ?[]const u8 = null,

    /// The instance details for this recommendation, including instance type,
    /// count, and model copies per instance.
    instance_details: ?[]const AIRecommendationInstanceDetail = null,

    /// The Amazon Resource Name (ARN) of the model package.
    model_package_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .inference_specification_name = "InferenceSpecificationName",
        .instance_details = "InstanceDetails",
        .model_package_arn = "ModelPackageArn",
    };
};
