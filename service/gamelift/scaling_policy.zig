const ComparisonOperatorType = @import("comparison_operator_type.zig").ComparisonOperatorType;
const MetricName = @import("metric_name.zig").MetricName;
const PolicyType = @import("policy_type.zig").PolicyType;
const ScalingAdjustmentType = @import("scaling_adjustment_type.zig").ScalingAdjustmentType;
const ScalingStatusType = @import("scaling_status_type.zig").ScalingStatusType;
const TargetConfiguration = @import("target_configuration.zig").TargetConfiguration;
const LocationUpdateStatus = @import("location_update_status.zig").LocationUpdateStatus;

/// Rule that controls how a fleet is scaled. Scaling policies are uniquely
/// identified by
/// the combination of name and fleet ID.
pub const ScalingPolicy = struct {
    /// Comparison operator to use when measuring a metric against the threshold
    /// value.
    comparison_operator: ?ComparisonOperatorType = null,

    /// Length of time (in minutes) the metric must be at or beyond the threshold
    /// before a
    /// scaling event is triggered.
    evaluation_periods: ?i32 = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers fleet resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::fleet/fleet-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the fleet that is associated with this scaling
    /// policy.
    fleet_id: ?[]const u8 = null,

    /// The fleet location.
    location: ?[]const u8 = null,

    /// Name of the Amazon GameLift Servers-defined metric that is used to trigger a
    /// scaling adjustment. For
    /// detailed descriptions of fleet metrics, see [Monitor Amazon GameLift Servers
    /// with Amazon
    /// CloudWatch](https://docs.aws.amazon.com/gamelift/latest/developerguide/monitoring-cloudwatch.html).
    ///
    /// * **ActivatingGameSessions** -- Game sessions in
    /// the process of being created.
    ///
    /// * **ActiveGameSessions** -- Game sessions that
    /// are currently running.
    ///
    /// * **ActiveInstances** -- Fleet instances that
    /// are currently running at least one game session.
    ///
    /// * **AvailableGameSessions** -- Additional game
    /// sessions that fleet could host simultaneously, given current capacity.
    ///
    /// * **AvailablePlayerSessions** -- Empty player
    /// slots in currently active game sessions. This includes game sessions that
    /// are
    /// not currently accepting players. Reserved player slots are not
    /// included.
    ///
    /// * **CurrentPlayerSessions** -- Player slots in
    /// active game sessions that are being used by a player or are reserved for a
    /// player.
    ///
    /// * **IdleInstances** -- Active instances that are
    /// currently hosting zero game sessions.
    ///
    /// * **PercentAvailableGameSessions** -- Unused
    /// percentage of the total number of game sessions that a fleet could host
    /// simultaneously, given current capacity. Use this metric for a target-based
    /// scaling policy.
    ///
    /// * **PercentIdleInstances** -- Percentage of the
    /// total number of active instances that are hosting zero game sessions.
    ///
    /// * **QueueDepth** -- Pending game session
    /// placement requests, in any queue, where the current fleet is the
    /// top-priority
    /// destination.
    ///
    /// * **WaitTime** -- Current wait time for pending
    /// game session placement requests, in any queue, where the current fleet is
    /// the
    /// top-priority destination.
    metric_name: ?MetricName = null,

    /// A descriptive label that is associated with a fleet's scaling policy. Policy
    /// names do not need to be unique.
    name: ?[]const u8 = null,

    /// The type of scaling policy to create. For a target-based policy, set the
    /// parameter
    /// *MetricName* to 'PercentAvailableGameSessions' and specify a
    /// *TargetConfiguration*. For a rule-based policy set the following
    /// parameters: *MetricName*, *ComparisonOperator*,
    /// *Threshold*, *EvaluationPeriods*,
    /// *ScalingAdjustmentType*, and
    /// *ScalingAdjustment*.
    policy_type: ?PolicyType = null,

    /// Amount of adjustment to make, based on the scaling adjustment type.
    scaling_adjustment: ?i32 = null,

    /// The type of adjustment to make to a fleet's instance count.
    ///
    /// * **ChangeInCapacity** -- add (or subtract) the
    /// scaling adjustment value from the current instance count. Positive values
    /// scale
    /// up while negative values scale down.
    ///
    /// * **ExactCapacity** -- set the instance count to the
    /// scaling adjustment value.
    ///
    /// * **PercentChangeInCapacity** -- increase or reduce
    /// the current instance count by the scaling adjustment, read as a percentage.
    /// Positive values scale up while negative values scale down.
    scaling_adjustment_type: ?ScalingAdjustmentType = null,

    /// Current status of the scaling policy. The scaling policy can be in force
    /// only when in
    /// an `ACTIVE` status. Scaling policies can be suspended for individual fleets.
    /// If the policy is suspended for a fleet, the policy status does not change.
    ///
    /// * **ACTIVE** -- The scaling policy can be used for
    /// auto-scaling a fleet.
    ///
    /// * **UPDATE_REQUESTED** -- A request to update the
    /// scaling policy has been received.
    ///
    /// * **UPDATING** -- A change is being made to the
    /// scaling policy.
    ///
    /// * **DELETE_REQUESTED** -- A request to delete the
    /// scaling policy has been received.
    ///
    /// * **DELETING** -- The scaling policy is being
    /// deleted.
    ///
    /// * **DELETED** -- The scaling policy has been
    /// deleted.
    ///
    /// * **ERROR** -- An error occurred in creating the
    /// policy. It should be removed and recreated.
    status: ?ScalingStatusType = null,

    /// An object that contains settings for a target-based scaling policy.
    target_configuration: ?TargetConfiguration = null,

    /// Metric value used to trigger a scaling event.
    threshold: ?f64 = null,

    /// The current status of the fleet's scaling policies in a requested fleet
    /// location. The
    /// status `PENDING_UPDATE` indicates that an update was requested for the fleet
    /// but has not yet been completed for the location.
    update_status: ?LocationUpdateStatus = null,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .evaluation_periods = "EvaluationPeriods",
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .location = "Location",
        .metric_name = "MetricName",
        .name = "Name",
        .policy_type = "PolicyType",
        .scaling_adjustment = "ScalingAdjustment",
        .scaling_adjustment_type = "ScalingAdjustmentType",
        .status = "Status",
        .target_configuration = "TargetConfiguration",
        .threshold = "Threshold",
        .update_status = "UpdateStatus",
    };
};
