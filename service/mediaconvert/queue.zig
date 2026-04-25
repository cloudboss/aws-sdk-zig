const PricingPlan = @import("pricing_plan.zig").PricingPlan;
const ReservationPlan = @import("reservation_plan.zig").ReservationPlan;
const ServiceOverride = @import("service_override.zig").ServiceOverride;
const QueueStatus = @import("queue_status.zig").QueueStatus;
const Type = @import("type.zig").Type;

/// You can use queues to manage the resources that are available to your AWS
/// account for running multiple transcoding jobs at the same time. If you don't
/// specify a queue, the service sends all jobs through the default queue. For
/// more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/working-with-queues.html.
pub const Queue = struct {
    /// An identifier for this resource that is unique within all of AWS.
    arn: ?[]const u8 = null,

    /// The maximum number of jobs your queue can process concurrently.
    concurrent_jobs: ?i32 = null,

    /// The timestamp in epoch seconds for when you created the queue.
    created_at: ?i64 = null,

    /// An optional description that you create for each queue.
    description: ?[]const u8 = null,

    /// The timestamp in epoch seconds for when you most recently updated the queue.
    last_updated: ?i64 = null,

    /// Specify the maximum number of Elemental Inference feeds MediaConvert can
    /// process concurrently.
    maximum_concurrent_feeds: ?i32 = null,

    /// A name that you create for each queue. Each name must be unique within your
    /// account.
    name: []const u8,

    /// Specifies whether the pricing plan for the queue is on-demand or reserved.
    /// For on-demand, you pay per minute, billed in increments of .01 minute. For
    /// reserved, you pay for the transcoding capacity of the entire queue,
    /// regardless of how much or how little you use it. Reserved pricing requires a
    /// 12-month commitment.
    pricing_plan: ?PricingPlan = null,

    /// The estimated number of jobs with a PROGRESSING status.
    progressing_jobs_count: ?i32 = null,

    /// Details about the pricing plan for your reserved queue. Required for
    /// reserved queues and not applicable to on-demand queues.
    reservation_plan: ?ReservationPlan = null,

    /// A list of any service overrides applied by MediaConvert to the settings that
    /// you have configured. If you see any overrides, we recommend that you contact
    /// AWS Support.
    service_overrides: ?[]const ServiceOverride = null,

    /// Queues can be ACTIVE or PAUSED. If you pause a queue, the service won't
    /// begin processing jobs in that queue. Jobs that are running when you pause
    /// the queue continue to run until they finish or result in an error.
    status: ?QueueStatus = null,

    /// The estimated number of jobs with a SUBMITTED status.
    submitted_jobs_count: ?i32 = null,

    /// Specifies whether this on-demand queue is system or custom. System queues
    /// are built in. You can't modify or delete system queues. You can create and
    /// modify custom queues.
    @"type": ?Type = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .concurrent_jobs = "ConcurrentJobs",
        .created_at = "CreatedAt",
        .description = "Description",
        .last_updated = "LastUpdated",
        .maximum_concurrent_feeds = "MaximumConcurrentFeeds",
        .name = "Name",
        .pricing_plan = "PricingPlan",
        .progressing_jobs_count = "ProgressingJobsCount",
        .reservation_plan = "ReservationPlan",
        .service_overrides = "ServiceOverrides",
        .status = "Status",
        .submitted_jobs_count = "SubmittedJobsCount",
        .@"type" = "Type",
    };
};
