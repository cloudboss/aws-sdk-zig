const ExportingLocation = @import("exporting_location.zig").ExportingLocation;
const JobStats = @import("job_stats.zig").JobStats;
const IdentityResolutionJobStatus = @import("identity_resolution_job_status.zig").IdentityResolutionJobStatus;

/// Information about the Identity Resolution Job.
pub const IdentityResolutionJob = struct {
    /// The unique name of the domain.
    domain_name: ?[]const u8,

    /// The S3 location where the Identity Resolution Job writes result files.
    exporting_location: ?ExportingLocation,

    /// The timestamp of when the job was completed.
    job_end_time: ?i64,

    /// The unique identifier of the Identity Resolution Job.
    job_id: ?[]const u8,

    /// The timestamp of when the job was started or will be started.
    job_start_time: ?i64,

    /// Statistics about an Identity Resolution Job.
    job_stats: ?JobStats,

    /// The error messages that are generated when the Identity Resolution Job runs.
    message: ?[]const u8,

    /// The status of the Identity Resolution Job.
    ///
    /// * `PENDING`: The Identity Resolution Job is scheduled but has not started
    ///   yet. If you turn
    /// off the Identity Resolution feature in your domain, jobs in the `PENDING`
    /// state are
    /// deleted.
    ///
    /// * `PREPROCESSING`: The Identity Resolution Job is loading your data.
    ///
    /// * `FIND_MATCHING`: The Identity Resolution Job is using the machine learning
    ///   model to
    /// identify profiles that belong to the same matching group.
    ///
    /// * `MERGING`: The Identity Resolution Job is merging duplicate profiles.
    ///
    /// * `COMPLETED`: The Identity Resolution Job completed successfully.
    ///
    /// * `PARTIAL_SUCCESS`: There's a system error and not all of the data is
    /// merged. The Identity Resolution Job writes a message indicating the source
    /// of the problem.
    ///
    /// * `FAILED`: The Identity Resolution Job did not merge any data. It writes a
    ///   message
    /// indicating the source of the problem.
    status: ?IdentityResolutionJobStatus,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .exporting_location = "ExportingLocation",
        .job_end_time = "JobEndTime",
        .job_id = "JobId",
        .job_start_time = "JobStartTime",
        .job_stats = "JobStats",
        .message = "Message",
        .status = "Status",
    };
};
