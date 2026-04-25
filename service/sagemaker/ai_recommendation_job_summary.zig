const AIRecommendationJobStatus = @import("ai_recommendation_job_status.zig").AIRecommendationJobStatus;

/// Summary information about an AI recommendation job.
pub const AIRecommendationJobSummary = struct {
    /// The Amazon Resource Name (ARN) of the recommendation job.
    ai_recommendation_job_arn: []const u8,

    /// The name of the recommendation job.
    ai_recommendation_job_name: []const u8,

    /// The status of the recommendation job.
    ai_recommendation_job_status: AIRecommendationJobStatus,

    /// A timestamp that indicates when the recommendation job was created.
    creation_time: i64,

    /// A timestamp that indicates when the recommendation job completed.
    end_time: ?i64 = null,

    pub const json_field_names = .{
        .ai_recommendation_job_arn = "AIRecommendationJobArn",
        .ai_recommendation_job_name = "AIRecommendationJobName",
        .ai_recommendation_job_status = "AIRecommendationJobStatus",
        .creation_time = "CreationTime",
        .end_time = "EndTime",
    };
};
