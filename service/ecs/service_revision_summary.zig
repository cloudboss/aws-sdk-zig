/// The information about the number of requested, pending, and running tasks
/// for a
/// service revision.
pub const ServiceRevisionSummary = struct {
    /// The ARN of the service revision.
    arn: ?[]const u8,

    /// The number of pending tasks for the service revision.
    pending_task_count: i32 = 0,

    /// The percentage of production traffic that is directed to this service
    /// revision. This
    /// value represents a snapshot of the traffic distribution and may not reflect
    /// real-time
    /// changes during active deployments. Valid values are 0.0 to 100.0.
    requested_production_traffic_weight: ?f64,

    /// The number of requested tasks for the service revision.
    requested_task_count: i32 = 0,

    /// The percentage of test traffic that is directed to this service revision.
    /// This value
    /// represents a snapshot of the traffic distribution and may not reflect
    /// real-time changes
    /// during active deployments. Valid values are 0.0 to 100.0.
    requested_test_traffic_weight: ?f64,

    /// The number of running tasks for the service revision.
    running_task_count: i32 = 0,

    pub const json_field_names = .{
        .arn = "arn",
        .pending_task_count = "pendingTaskCount",
        .requested_production_traffic_weight = "requestedProductionTrafficWeight",
        .requested_task_count = "requestedTaskCount",
        .requested_test_traffic_weight = "requestedTestTrafficWeight",
        .running_task_count = "runningTaskCount",
    };
};
