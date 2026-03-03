const ProtectedJobComputeConfiguration = @import("protected_job_compute_configuration.zig").ProtectedJobComputeConfiguration;
const ProtectedJobError = @import("protected_job_error.zig").ProtectedJobError;
const ProtectedJobParameters = @import("protected_job_parameters.zig").ProtectedJobParameters;
const ProtectedJobResult = @import("protected_job_result.zig").ProtectedJobResult;
const ProtectedJobResultConfigurationOutput = @import("protected_job_result_configuration_output.zig").ProtectedJobResultConfigurationOutput;
const ProtectedJobStatistics = @import("protected_job_statistics.zig").ProtectedJobStatistics;
const ProtectedJobStatus = @import("protected_job_status.zig").ProtectedJobStatus;

/// The parameters for an Clean Rooms protected job.
pub const ProtectedJob = struct {
    /// The compute configuration for the protected job.
    compute_configuration: ?ProtectedJobComputeConfiguration = null,

    /// The creation time of the protected job.
    create_time: i64,

    /// The error from the protected job.
    @"error": ?ProtectedJobError = null,

    /// The identifier for a protected job instance.
    id: []const u8,

    /// The job parameters for the protected job.
    job_parameters: ?ProtectedJobParameters = null,

    /// The ARN of the membership.
    membership_arn: []const u8,

    /// he identifier for the membership.
    membership_id: []const u8,

    /// The result of the protected job.
    result: ?ProtectedJobResult = null,

    /// Contains any details needed to write the job results.
    result_configuration: ?ProtectedJobResultConfigurationOutput = null,

    /// The statistics of the protected job.
    statistics: ?ProtectedJobStatistics = null,

    /// The status of the protected job.
    status: ProtectedJobStatus,

    pub const json_field_names = .{
        .compute_configuration = "computeConfiguration",
        .create_time = "createTime",
        .@"error" = "error",
        .id = "id",
        .job_parameters = "jobParameters",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .result = "result",
        .result_configuration = "resultConfiguration",
        .statistics = "statistics",
        .status = "status",
    };
};
