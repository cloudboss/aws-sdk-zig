const aws = @import("aws");

const JobPrimaryStatus = @import("job_primary_status.zig").JobPrimaryStatus;

/// Provides summary information about an Amazon Braket hybrid job.
pub const JobSummary = struct {
    /// The time at which the Amazon Braket hybrid job was created.
    created_at: i64,

    /// The primary device used by an Amazon Braket hybrid job.
    device: []const u8,

    /// The time at which the Amazon Braket hybrid job ended.
    ended_at: ?i64 = null,

    /// The ARN of the Amazon Braket hybrid job.
    job_arn: []const u8,

    /// The name of the Amazon Braket hybrid job.
    job_name: []const u8,

    /// The time at which the Amazon Braket hybrid job was started.
    started_at: ?i64 = null,

    /// The status of the Amazon Braket hybrid job.
    status: JobPrimaryStatus,

    /// Displays the key, value pairs of tags associated with this hybrid job.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .device = "device",
        .ended_at = "endedAt",
        .job_arn = "jobArn",
        .job_name = "jobName",
        .started_at = "startedAt",
        .status = "status",
        .tags = "tags",
    };
};
