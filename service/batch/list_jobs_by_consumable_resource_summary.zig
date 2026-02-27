const ConsumableResourceProperties = @import("consumable_resource_properties.zig").ConsumableResourceProperties;

/// Current information about a consumable resource required by a job.
pub const ListJobsByConsumableResourceSummary = struct {
    /// Contains a list of consumable resources required by the job.
    consumable_resource_properties: ConsumableResourceProperties,

    /// The Unix timestamp (in milliseconds) for when the consumable resource was
    /// created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the job.
    job_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the job definition.
    job_definition_arn: ?[]const u8,

    /// The name of the job.
    job_name: []const u8,

    /// The Amazon Resource Name (ARN) of the job queue.
    job_queue_arn: []const u8,

    /// The status of the job. Can be one of:
    ///
    /// * `SUBMITTED`
    ///
    /// * `PENDING`
    ///
    /// * `RUNNABLE`
    ///
    /// * `STARTING`
    ///
    /// * `RUNNING`
    ///
    /// * `SUCCEEDED`
    ///
    /// * `FAILED`
    job_status: []const u8,

    /// The total amount of the consumable resource that is available.
    quantity: i64,

    /// The fair-share scheduling policy identifier for the job.
    share_identifier: ?[]const u8,

    /// The Unix timestamp for when the job was started. More specifically, it's
    /// when the job transitioned
    /// from the `STARTING` state to the `RUNNING` state.
    started_at: ?i64,

    /// A short, human-readable string to provide more details for the current
    /// status of the job.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .consumable_resource_properties = "consumableResourceProperties",
        .created_at = "createdAt",
        .job_arn = "jobArn",
        .job_definition_arn = "jobDefinitionArn",
        .job_name = "jobName",
        .job_queue_arn = "jobQueueArn",
        .job_status = "jobStatus",
        .quantity = "quantity",
        .share_identifier = "shareIdentifier",
        .started_at = "startedAt",
        .status_reason = "statusReason",
    };
};
