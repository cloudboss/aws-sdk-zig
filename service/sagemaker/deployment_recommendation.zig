const RealTimeInferenceRecommendation = @import("real_time_inference_recommendation.zig").RealTimeInferenceRecommendation;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;

/// A set of recommended deployment configurations for the model. To get more
/// advanced recommendations, see
/// [CreateInferenceRecommendationsJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateInferenceRecommendationsJob.html) to create an inference recommendation job.
pub const DeploymentRecommendation = struct {
    /// A list of
    /// [RealTimeInferenceRecommendation](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_RealTimeInferenceRecommendation.html) items.
    real_time_inference_recommendations: ?[]const RealTimeInferenceRecommendation,

    /// Status of the deployment recommendation. The status `NOT_APPLICABLE` means
    /// that SageMaker is unable to provide a default recommendation for the model
    /// using the information provided. If the deployment status is `IN_PROGRESS`,
    /// retry your API call after a few seconds to get a `COMPLETED` deployment
    /// recommendation.
    recommendation_status: RecommendationStatus,

    pub const json_field_names = .{
        .real_time_inference_recommendations = "RealTimeInferenceRecommendations",
        .recommendation_status = "RecommendationStatus",
    };
};
