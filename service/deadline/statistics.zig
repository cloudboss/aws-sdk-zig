const Stats = @import("stats.zig").Stats;
const UsageType = @import("usage_type.zig").UsageType;

/// A list of statistics for a session.
pub const Statistics = struct {
    /// The end time for the aggregation.
    aggregation_end_time: ?i64 = null,

    /// The start time for the aggregation.
    aggregation_start_time: ?i64 = null,

    /// How the statistics should appear in USD. Options include: minimum, maximum,
    /// average or sum.
    cost_in_usd: Stats,

    /// The number of instances in a list of statistics.
    count: i32,

    /// The fleet ID.
    fleet_id: ?[]const u8 = null,

    /// The type of instance.
    instance_type: ?[]const u8 = null,

    /// The job ID.
    job_id: ?[]const u8 = null,

    /// The job name.
    job_name: ?[]const u8 = null,

    /// The licensed product.
    license_product: ?[]const u8 = null,

    /// The queue ID.
    queue_id: ?[]const u8 = null,

    /// The total aggregated runtime.
    runtime_in_seconds: Stats,

    /// The type of usage for the statistics.
    usage_type: ?UsageType = null,

    /// The user ID.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregation_end_time = "aggregationEndTime",
        .aggregation_start_time = "aggregationStartTime",
        .cost_in_usd = "costInUsd",
        .count = "count",
        .fleet_id = "fleetId",
        .instance_type = "instanceType",
        .job_id = "jobId",
        .job_name = "jobName",
        .license_product = "licenseProduct",
        .queue_id = "queueId",
        .runtime_in_seconds = "runtimeInSeconds",
        .usage_type = "usageType",
        .user_id = "userId",
    };
};
