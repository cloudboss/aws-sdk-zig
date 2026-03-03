const AudienceSize = @import("audience_size.zig").AudienceSize;
const AudienceExportJobStatus = @import("audience_export_job_status.zig").AudienceExportJobStatus;
const StatusDetails = @import("status_details.zig").StatusDetails;

/// Provides information about the audience export job.
pub const AudienceExportJobSummary = struct {
    /// The Amazon Resource Name (ARN) of the audience generation job that was
    /// exported.
    audience_generation_job_arn: []const u8,

    audience_size: AudienceSize,

    /// The time at which the audience export job was created.
    create_time: i64,

    /// The description of the audience export job.
    description: ?[]const u8 = null,

    /// The name of the audience export job.
    name: []const u8,

    /// The Amazon S3 bucket where the audience export is stored.
    output_location: ?[]const u8 = null,

    /// The status of the audience export job.
    status: AudienceExportJobStatus,

    status_details: ?StatusDetails = null,

    /// The most recent time at which the audience export job was updated.
    update_time: i64,

    pub const json_field_names = .{
        .audience_generation_job_arn = "audienceGenerationJobArn",
        .audience_size = "audienceSize",
        .create_time = "createTime",
        .description = "description",
        .name = "name",
        .output_location = "outputLocation",
        .status = "status",
        .status_details = "statusDetails",
        .update_time = "updateTime",
    };
};
