const JobAction = @import("job_action.zig").JobAction;
const JobActionOptions = @import("job_action_options.zig").JobActionOptions;
const JobError = @import("job_error.zig").JobError;
const JobInputOptions = @import("job_input_options.zig").JobInputOptions;
const JobOutputOptions = @import("job_output_options.zig").JobOutputOptions;
const JobStatus = @import("job_status.zig").JobStatus;

/// Job summary information returned in list operations.
pub const ListJobsResponseEntry = struct {
    /// Action performed by the job.
    action: JobAction,

    /// Additional options for configuring job action parameters.
    action_options: ?JobActionOptions = null,

    /// Job creation time in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sss`.
    created_at: i64,

    /// Job completion time in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sss`. Only returned for jobs in a terminal status:
    /// `Completed` | `Failed` | `Cancelled`.
    ended_at: ?i64 = null,

    /// Error information if the job failed.
    @"error": ?JobError = null,

    /// IAM role used for job execution.
    execution_role_arn: []const u8,

    /// Input configuration.
    input_options: JobInputOptions,

    /// Amazon Resource Name (ARN) of the job.
    job_arn: []const u8,

    /// Unique job identifier.
    job_id: []const u8,

    /// Job name (if provided during creation).
    name: ?[]const u8 = null,

    /// Output configuration.
    output_options: JobOutputOptions,

    /// Current job status.
    status: JobStatus,

    /// Last update time in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sss`.
    updated_at: i64,

    pub const json_field_names = .{
        .action = "Action",
        .action_options = "ActionOptions",
        .created_at = "CreatedAt",
        .ended_at = "EndedAt",
        .@"error" = "Error",
        .execution_role_arn = "ExecutionRoleArn",
        .input_options = "InputOptions",
        .job_arn = "JobArn",
        .job_id = "JobId",
        .name = "Name",
        .output_options = "OutputOptions",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
