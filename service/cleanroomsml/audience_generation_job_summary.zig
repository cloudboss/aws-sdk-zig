const AudienceGenerationJobStatus = @import("audience_generation_job_status.zig").AudienceGenerationJobStatus;

/// Provides information about the configured audience generation job.
pub const AudienceGenerationJobSummary = struct {
    /// The Amazon Resource Name (ARN) of the audience generation job.
    audience_generation_job_arn: []const u8,

    /// The identifier of the collaboration that contains this audience generation
    /// job.
    collaboration_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the configured audience model that was
    /// used for this audience generation job.
    configured_audience_model_arn: []const u8,

    /// The time at which the audience generation job was created.
    create_time: i64,

    /// The description of the audience generation job.
    description: ?[]const u8 = null,

    /// The name of the audience generation job.
    name: []const u8,

    /// The AWS Account that submitted the job.
    started_by: ?[]const u8 = null,

    /// The status of the audience generation job.
    status: AudienceGenerationJobStatus,

    /// The most recent time at which the audience generation job was updated.
    update_time: i64,

    pub const json_field_names = .{
        .audience_generation_job_arn = "audienceGenerationJobArn",
        .collaboration_id = "collaborationId",
        .configured_audience_model_arn = "configuredAudienceModelArn",
        .create_time = "createTime",
        .description = "description",
        .name = "name",
        .started_by = "startedBy",
        .status = "status",
        .update_time = "updateTime",
    };
};
