const aws = @import("aws");

const AbortConfig = @import("abort_config.zig").AbortConfig;
const JobExecutionsRetryConfig = @import("job_executions_retry_config.zig").JobExecutionsRetryConfig;
const JobExecutionsRolloutConfig = @import("job_executions_rollout_config.zig").JobExecutionsRolloutConfig;
const JobProcessDetails = @import("job_process_details.zig").JobProcessDetails;
const PresignedUrlConfig = @import("presigned_url_config.zig").PresignedUrlConfig;
const ScheduledJobRollout = @import("scheduled_job_rollout.zig").ScheduledJobRollout;
const SchedulingConfig = @import("scheduling_config.zig").SchedulingConfig;
const JobStatus = @import("job_status.zig").JobStatus;
const TargetSelection = @import("target_selection.zig").TargetSelection;
const TimeoutConfig = @import("timeout_config.zig").TimeoutConfig;

/// The `Job` object contains details about a job.
pub const Job = struct {
    /// Configuration for criteria to abort the job.
    abort_config: ?AbortConfig,

    /// If the job was updated, describes the reason for the update.
    comment: ?[]const u8,

    /// The time, in seconds since the epoch, when the job was completed.
    completed_at: ?i64,

    /// The time, in seconds since the epoch, when the job was created.
    created_at: ?i64,

    /// A short text description of the job.
    description: ?[]const u8,

    /// The package version Amazon Resource Names (ARNs) that are installed on the
    /// device when the job
    /// successfully completes. The package version must be in either the Published
    /// or
    /// Deprecated state when the job deploys. For more information, see [Package
    /// version
    /// lifecycle](https://docs.aws.amazon.com/iot/latest/developerguide/preparing-to-use-software-package-catalog.html#package-version-lifecycle).The package version must be in either the
    /// Published or Deprecated state when the job deploys. For more information,
    /// see [Package version
    /// lifecycle](https://docs.aws.amazon.com/iot/latest/developerguide/preparing-to-use-software-package-catalog.html#package-version-lifecycle).
    ///
    /// **Note:**The following Length Constraints relates to a
    /// single ARN. Up to 25 package version ARNs are allowed.
    destination_package_versions: ?[]const []const u8,

    /// A key-value map that pairs the patterns that need to be replaced in a
    /// managed
    /// template job document schema. You can use the description of each key as a
    /// guidance to
    /// specify the inputs during runtime when creating a job.
    ///
    /// `documentParameters` can only be used when creating jobs from Amazon Web
    /// Services
    /// managed templates. This parameter can't be used with custom job templates or
    /// to
    /// create jobs from them.
    document_parameters: ?[]const aws.map.StringMapEntry,

    /// Will be `true` if the job was canceled with the optional
    /// `force` parameter set to `true`.
    force_canceled: ?bool,

    /// Indicates whether a job is concurrent. Will be true when a job is rolling
    /// out new job
    /// executions or canceling previously created executions, otherwise false.
    is_concurrent: ?bool,

    /// An ARN identifying the job with format
    /// "arn:aws:iot:region:account:job/jobId".
    job_arn: ?[]const u8,

    /// The configuration for the criteria to retry the job.
    job_executions_retry_config: ?JobExecutionsRetryConfig,

    /// Allows you to create a staged rollout of a job.
    job_executions_rollout_config: ?JobExecutionsRolloutConfig,

    /// The unique identifier you assigned to this job when it was created.
    job_id: ?[]const u8,

    /// Details about the job process.
    job_process_details: ?JobProcessDetails,

    /// The ARN of the job template used to create the job.
    job_template_arn: ?[]const u8,

    /// The time, in seconds since the epoch, when the job was last updated.
    last_updated_at: ?i64,

    /// The namespace used to indicate that a job is a customer-managed job.
    ///
    /// When you specify a value for this parameter, Amazon Web Services IoT Core
    /// sends jobs notifications to
    /// MQTT topics that contain the value in the following format.
    ///
    /// `$aws/things/*THING_NAME*/jobs/*JOB_ID*/notify-namespace-*NAMESPACE_ID*/`
    ///
    /// The `namespaceId` feature is only supported by IoT Greengrass at this time.
    /// For
    /// more information, see [Setting up IoT Greengrass core
    /// devices.](https://docs.aws.amazon.com/greengrass/v2/developerguide/setting-up.html)
    namespace_id: ?[]const u8,

    /// Configuration for pre-signed S3 URLs.
    presigned_url_config: ?PresignedUrlConfig,

    /// If the job was updated, provides the reason code for the update.
    reason_code: ?[]const u8,

    /// Displays the next seven maintenance window occurrences and their start
    /// times.
    scheduled_job_rollouts: ?[]const ScheduledJobRollout,

    /// The configuration that allows you to schedule a job for a future date and
    /// time in
    /// addition to specifying the end behavior for each job execution.
    scheduling_config: ?SchedulingConfig,

    /// The status of the job, one of `IN_PROGRESS`, `CANCELED`,
    /// `DELETION_IN_PROGRESS` or `COMPLETED`.
    status: ?JobStatus,

    /// A list of IoT things and thing groups to which the job should be sent.
    targets: ?[]const []const u8,

    /// Specifies whether the job will continue to run (CONTINUOUS), or will be
    /// complete
    /// after all those things specified as targets have completed the job
    /// (SNAPSHOT). If
    /// continuous, the job may also be run on a thing when a change is detected in
    /// a target.
    /// For example, a job will run on a device when the thing representing the
    /// device is added
    /// to a target group, even after the job was completed by all things originally
    /// in the
    /// group.
    ///
    /// We recommend that you use continuous jobs instead of snapshot jobs for
    /// dynamic
    /// thing group targets. By using continuous jobs, devices that join the group
    /// receive
    /// the job execution even after the job has been created.
    target_selection: ?TargetSelection,

    /// Specifies the amount of time each device has to finish its execution of the
    /// job. A
    /// timer is started when the job execution status is set to `IN_PROGRESS`. If
    /// the job execution status is not set to another terminal state before the
    /// timer expires,
    /// it will be automatically set to `TIMED_OUT`.
    timeout_config: ?TimeoutConfig,

    pub const json_field_names = .{
        .abort_config = "abortConfig",
        .comment = "comment",
        .completed_at = "completedAt",
        .created_at = "createdAt",
        .description = "description",
        .destination_package_versions = "destinationPackageVersions",
        .document_parameters = "documentParameters",
        .force_canceled = "forceCanceled",
        .is_concurrent = "isConcurrent",
        .job_arn = "jobArn",
        .job_executions_retry_config = "jobExecutionsRetryConfig",
        .job_executions_rollout_config = "jobExecutionsRolloutConfig",
        .job_id = "jobId",
        .job_process_details = "jobProcessDetails",
        .job_template_arn = "jobTemplateArn",
        .last_updated_at = "lastUpdatedAt",
        .namespace_id = "namespaceId",
        .presigned_url_config = "presignedUrlConfig",
        .reason_code = "reasonCode",
        .scheduled_job_rollouts = "scheduledJobRollouts",
        .scheduling_config = "schedulingConfig",
        .status = "status",
        .targets = "targets",
        .target_selection = "targetSelection",
        .timeout_config = "timeoutConfig",
    };
};
