const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The Application Auto Scaling policy created by Amazon ECS when you create an
/// Express service.
pub const ManagedApplicationAutoScalingPolicy = struct {
    /// The Amazon Resource Name (ARN) of the Application Auto Scaling policy
    /// associated with the Express service.
    arn: ?[]const u8 = null,

    /// The metric used for auto scaling decisions. The available metrics are
    /// `ECSServiceAverageCPUUtilization`, `ECSServiceAverageMemoryUtilization`, and
    /// `ALBRequestCOuntPerTarget`.
    metric: []const u8,

    /// The type of Application Auto Scaling policy associated with the Express
    /// service. Valid values are `TargetTrackingScaling`, `StepScaling`, and
    /// `PredictiveScaling`.
    policy_type: []const u8,

    /// The status of Application Auto Scaling policy creation.
    status: ManagedResourceStatus,

    /// Information about why the Application Auto Scaling policy is in the current
    /// status.
    status_reason: ?[]const u8 = null,

    /// The target value for the auto scaling metric.
    target_value: f64 = 0,

    /// The Unix timestamp for when the Application Auto Scaling policy was last
    /// updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .metric = "metric",
        .policy_type = "policyType",
        .status = "status",
        .status_reason = "statusReason",
        .target_value = "targetValue",
        .updated_at = "updatedAt",
    };
};
