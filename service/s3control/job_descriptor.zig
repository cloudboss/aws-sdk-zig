const JobFailure = @import("job_failure.zig").JobFailure;
const S3GeneratedManifestDescriptor = @import("s3_generated_manifest_descriptor.zig").S3GeneratedManifestDescriptor;
const JobManifest = @import("job_manifest.zig").JobManifest;
const JobManifestGenerator = @import("job_manifest_generator.zig").JobManifestGenerator;
const JobOperation = @import("job_operation.zig").JobOperation;
const JobProgressSummary = @import("job_progress_summary.zig").JobProgressSummary;
const JobReport = @import("job_report.zig").JobReport;
const JobStatus = @import("job_status.zig").JobStatus;

/// A container element for the job configuration and status information
/// returned by a
/// `Describe Job` request.
pub const JobDescriptor = struct {
    /// Indicates whether confirmation is required before Amazon S3 begins running
    /// the specified job.
    /// Confirmation is required only for jobs created through the Amazon S3
    /// console.
    confirmation_required: ?bool,

    /// A timestamp indicating when this job was created.
    creation_time: ?i64,

    /// The description for this job, if one was provided in this job's `Create Job`
    /// request.
    description: ?[]const u8,

    /// If the specified job failed, this field contains information describing the
    /// failure.
    failure_reasons: ?[]const JobFailure,

    /// The attribute of the JobDescriptor containing details about the job's
    /// generated
    /// manifest.
    generated_manifest_descriptor: ?S3GeneratedManifestDescriptor,

    /// The Amazon Resource Name (ARN) for this job.
    job_arn: ?[]const u8,

    /// The ID for the specified job.
    job_id: ?[]const u8,

    /// The configuration information for the specified job's manifest object.
    manifest: ?JobManifest,

    /// The manifest generator that was used to generate a job manifest for this
    /// job.
    manifest_generator: ?JobManifestGenerator,

    /// The operation that the specified job is configured to run on the objects
    /// listed in the
    /// manifest.
    operation: ?JobOperation,

    /// The priority of the specified job.
    priority: i32 = 0,

    /// Describes the total number of tasks that the specified job has run, the
    /// number of tasks
    /// that succeeded, and the number of tasks that failed.
    progress_summary: ?JobProgressSummary,

    /// Contains the configuration information for the job-completion report if you
    /// requested
    /// one in the `Create Job` request.
    report: ?JobReport,

    /// The Amazon Resource Name (ARN) for the Identity and Access Management (IAM)
    /// role assigned to run the tasks
    /// for this job.
    role_arn: ?[]const u8,

    /// The current status of the specified job.
    status: ?JobStatus,

    /// The reason for updating the job.
    status_update_reason: ?[]const u8,

    /// The reason why the specified job was suspended. A job is only suspended if
    /// you create it
    /// through the Amazon S3 console. When you create the job, it enters the
    /// `Suspended`
    /// state to await confirmation before running. After you confirm the job, it
    /// automatically
    /// exits the `Suspended` state.
    suspended_cause: ?[]const u8,

    /// The timestamp when this job was suspended, if it has been suspended.
    suspended_date: ?i64,

    /// A timestamp indicating when this job terminated. A job's termination date is
    /// the date
    /// and time when it succeeded, failed, or was canceled.
    termination_date: ?i64,
};
