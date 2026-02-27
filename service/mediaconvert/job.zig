const aws = @import("aws");

const AccelerationSettings = @import("acceleration_settings.zig").AccelerationSettings;
const AccelerationStatus = @import("acceleration_status.zig").AccelerationStatus;
const BillingTagsSource = @import("billing_tags_source.zig").BillingTagsSource;
const JobPhase = @import("job_phase.zig").JobPhase;
const HopDestination = @import("hop_destination.zig").HopDestination;
const JobMessages = @import("job_messages.zig").JobMessages;
const OutputGroupDetail = @import("output_group_detail.zig").OutputGroupDetail;
const QueueTransition = @import("queue_transition.zig").QueueTransition;
const JobSettings = @import("job_settings.zig").JobSettings;
const ShareStatus = @import("share_status.zig").ShareStatus;
const SimulateReservedQueue = @import("simulate_reserved_queue.zig").SimulateReservedQueue;
const JobStatus = @import("job_status.zig").JobStatus;
const StatusUpdateInterval = @import("status_update_interval.zig").StatusUpdateInterval;
const Timing = @import("timing.zig").Timing;
const WarningGroup = @import("warning_group.zig").WarningGroup;

/// Each job converts an input file into an output file or files. For more
/// information, see the User Guide at
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/what-is.html
pub const Job = struct {
    /// Accelerated transcoding can significantly speed up jobs with long, visually
    /// complex content.
    acceleration_settings: ?AccelerationSettings,

    /// Describes whether the current job is running with accelerated transcoding.
    /// For jobs that have Acceleration (AccelerationMode) set to DISABLED,
    /// AccelerationStatus is always NOT_APPLICABLE. For jobs that have Acceleration
    /// (AccelerationMode) set to ENABLED or PREFERRED, AccelerationStatus is one of
    /// the other states. AccelerationStatus is IN_PROGRESS initially, while the
    /// service determines whether the input files and job settings are compatible
    /// with accelerated transcoding. If they are, AcclerationStatus is ACCELERATED.
    /// If your input files and job settings aren't compatible with accelerated
    /// transcoding, the service either fails your job or runs it without
    /// accelerated transcoding, depending on how you set Acceleration
    /// (AccelerationMode). When the service runs your job without accelerated
    /// transcoding, AccelerationStatus is NOT_ACCELERATED.
    acceleration_status: ?AccelerationStatus,

    /// An identifier for this resource that is unique within all of AWS.
    arn: ?[]const u8,

    /// The tag type that AWS Billing and Cost Management will use to sort your AWS
    /// Elemental MediaConvert costs on any billing report that you set up.
    billing_tags_source: ?BillingTagsSource,

    /// Prevent duplicate jobs from being created and ensure idempotency for your
    /// requests. A client request token can be any string that includes up to 64
    /// ASCII characters. If you reuse a client request token within one minute of a
    /// successful request, the API returns the job details of the original request
    /// instead. For more information see
    /// https://docs.aws.amazon.com/mediaconvert/latest/apireference/idempotency.html.
    client_request_token: ?[]const u8,

    /// The time, in Unix epoch format in seconds, when the job got created.
    created_at: ?i64,

    /// A job's phase can be PROBING, TRANSCODING OR UPLOADING
    current_phase: ?JobPhase,

    /// Error code for the job
    error_code: ?i32,

    /// Error message of Job
    error_message: ?[]const u8,

    /// Optional list of hop destinations.
    hop_destinations: ?[]const HopDestination,

    /// A portion of the job's ARN, unique within your AWS Elemental MediaConvert
    /// resources
    id: ?[]const u8,

    /// The Job engine version that you requested for your job. Valid versions are
    /// in a YYYY-MM-DD format.
    job_engine_version_requested: ?[]const u8,

    /// The Job engine version that your job used. Job engine versions are in a
    /// YYYY-MM-DD format. When you request an expired version, the response for
    /// this property will be empty. Requests to create jobs with an expired version
    /// result in a regular job, as if no specific Job engine version was requested.
    /// When you request an invalid version, the response for this property will be
    /// empty. Requests to create jobs with an invalid version result in a 400 error
    /// message, and no job is created.
    job_engine_version_used: ?[]const u8,

    /// An estimate of how far your job has progressed. This estimate is shown as a
    /// percentage of the total time from when your job leaves its queue to when
    /// your output files appear in your output Amazon S3 bucket. AWS Elemental
    /// MediaConvert provides jobPercentComplete in CloudWatch STATUS_UPDATE events
    /// and in the response to GetJob and ListJobs requests. The jobPercentComplete
    /// estimate is reliable for the following input containers: Quicktime,
    /// Transport Stream, MP4, and MXF. For some jobs, the service can't provide
    /// information about job progress. In those cases, jobPercentComplete returns a
    /// null value.
    job_percent_complete: ?i32,

    /// The job template that the job is created from, if it is created from a job
    /// template.
    job_template: ?[]const u8,

    /// Contains information about the most recent share attempt for the job. For
    /// more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/creating-resource-share.html
    last_share_details: ?[]const u8,

    /// Provides messages from the service about jobs that you have already
    /// successfully submitted.
    messages: ?JobMessages,

    /// List of output group details
    output_group_details: ?[]const OutputGroupDetail,

    /// Relative priority on the job.
    priority: ?i32,

    /// When you create a job, you can specify a queue to send it to. If you don't
    /// specify, the job will go to the default queue. For more about queues, see
    /// the User Guide topic at
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/what-is.html
    queue: ?[]const u8,

    /// The job's queue hopping history.
    queue_transitions: ?[]const QueueTransition,

    /// The number of times that the service automatically attempted to process your
    /// job after encountering an error.
    retry_count: ?i32,

    /// The IAM role you use for creating this job. For details about permissions,
    /// see the User Guide topic at the User Guide at
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/iam-role.html
    role: []const u8,

    /// JobSettings contains all the transcode settings for a job.
    settings: JobSettings,

    /// A job's share status can be NOT_SHARED, INITIATED, or SHARED
    share_status: ?ShareStatus,

    /// Enable this setting when you run a test job to estimate how many reserved
    /// transcoding slots (RTS) you need. When this is enabled, MediaConvert runs
    /// your job from an on-demand queue with similar performance to what you will
    /// see with one RTS in a reserved queue. This setting is disabled by default.
    simulate_reserved_queue: ?SimulateReservedQueue,

    /// A job's status can be SUBMITTED, PROGRESSING, COMPLETE, CANCELED, or ERROR.
    status: ?JobStatus,

    /// Specify how often MediaConvert sends STATUS_UPDATE events to Amazon
    /// CloudWatch Events. Set the interval, in seconds, between status updates.
    /// MediaConvert sends an update at this interval from the time the service
    /// begins processing your job to the time it completes the transcode or
    /// encounters an error.
    status_update_interval: ?StatusUpdateInterval,

    /// Information about when jobs are submitted, started, and finished is
    /// specified in Unix epoch format in seconds.
    timing: ?Timing,

    /// User-defined metadata that you want to associate with an MediaConvert job.
    /// You specify metadata in key/value pairs.
    user_metadata: ?[]const aws.map.StringMapEntry,

    /// Contains any warning messages for the job. Use to help identify potential
    /// issues with your input, output, or job. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/warning_codes.html
    warnings: ?[]const WarningGroup,

    pub const json_field_names = .{
        .acceleration_settings = "AccelerationSettings",
        .acceleration_status = "AccelerationStatus",
        .arn = "Arn",
        .billing_tags_source = "BillingTagsSource",
        .client_request_token = "ClientRequestToken",
        .created_at = "CreatedAt",
        .current_phase = "CurrentPhase",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .hop_destinations = "HopDestinations",
        .id = "Id",
        .job_engine_version_requested = "JobEngineVersionRequested",
        .job_engine_version_used = "JobEngineVersionUsed",
        .job_percent_complete = "JobPercentComplete",
        .job_template = "JobTemplate",
        .last_share_details = "LastShareDetails",
        .messages = "Messages",
        .output_group_details = "OutputGroupDetails",
        .priority = "Priority",
        .queue = "Queue",
        .queue_transitions = "QueueTransitions",
        .retry_count = "RetryCount",
        .role = "Role",
        .settings = "Settings",
        .share_status = "ShareStatus",
        .simulate_reserved_queue = "SimulateReservedQueue",
        .status = "Status",
        .status_update_interval = "StatusUpdateInterval",
        .timing = "Timing",
        .user_metadata = "UserMetadata",
        .warnings = "Warnings",
    };
};
