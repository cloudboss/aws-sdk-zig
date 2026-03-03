const JobType = @import("job_type.zig").JobType;
const SourceUrlType = @import("source_url_type.zig").SourceUrlType;
const JobStatus = @import("job_status.zig").JobStatus;

/// Describes the summary for an execution job for an Amplify app.
pub const JobSummary = struct {
    /// The commit ID from a third-party repository provider for the job.
    commit_id: []const u8,

    /// The commit message from a third-party repository provider for the job.
    commit_message: []const u8,

    /// The commit date and time for the job.
    commit_time: i64,

    /// The end date and time for the job.
    end_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) for the job.
    job_arn: []const u8,

    /// The unique ID for the job.
    job_id: []const u8,

    /// The type for the job. If the value is `RELEASE`, the job was manually
    /// released from its source by using the `StartJob` API. This value is
    /// available
    /// only for apps that are connected to a repository.
    ///
    /// If the value is `RETRY`, the job was manually retried using the
    /// `StartJob` API. If the value is `WEB_HOOK`, the job was
    /// automatically triggered by webhooks. If the value is `MANUAL`, the job is
    /// for
    /// a manually deployed app. Manually deployed apps are not connected to a Git
    /// repository.
    job_type: JobType,

    /// The source URL for the files to deploy. The source URL can be either an HTTP
    /// GET URL
    /// that is publicly accessible and downloads a single .zip file, or an Amazon
    /// S3
    /// bucket and prefix.
    source_url: ?[]const u8 = null,

    /// The type of source specified by the `sourceURL`. If the value is
    /// `ZIP`, the source is a .zip file. If the value is
    /// `BUCKET_PREFIX`, the source is an Amazon S3 bucket and prefix. If
    /// no value is specified, the default is `ZIP`.
    source_url_type: ?SourceUrlType = null,

    /// The start date and time for the job.
    start_time: i64,

    /// The current status for the job.
    status: JobStatus,

    pub const json_field_names = .{
        .commit_id = "commitId",
        .commit_message = "commitMessage",
        .commit_time = "commitTime",
        .end_time = "endTime",
        .job_arn = "jobArn",
        .job_id = "jobId",
        .job_type = "jobType",
        .source_url = "sourceUrl",
        .source_url_type = "sourceUrlType",
        .start_time = "startTime",
        .status = "status",
    };
};
