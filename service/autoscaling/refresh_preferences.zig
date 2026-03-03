const AlarmSpecification = @import("alarm_specification.zig").AlarmSpecification;
const ScaleInProtectedInstances = @import("scale_in_protected_instances.zig").ScaleInProtectedInstances;
const StandbyInstances = @import("standby_instances.zig").StandbyInstances;

/// Describes the preferences for an instance refresh.
pub const RefreshPreferences = struct {
    /// (Optional) The CloudWatch alarm specification. CloudWatch alarms can be used
    /// to identify any
    /// issues and fail the operation if an alarm threshold is met.
    alarm_specification: ?AlarmSpecification = null,

    /// (Optional) Indicates whether to roll back the Auto Scaling group to its
    /// previous configuration
    /// if the instance refresh fails or a CloudWatch alarm threshold is met. The
    /// default is
    /// `false`.
    ///
    /// A rollback is not supported in the following situations:
    ///
    /// * There is no desired configuration specified for the instance refresh.
    ///
    /// * The Auto Scaling group has a launch template that uses an Amazon Web
    ///   Services Systems Manager
    /// parameter instead of an AMI ID for the `ImageId` property.
    ///
    /// * The Auto Scaling group uses the launch template's `$Latest` or
    /// `$Default` version.
    ///
    /// For more information, see [Undo changes with a
    /// rollback](https://docs.aws.amazon.com/autoscaling/ec2/userguide/instance-refresh-rollback.html) in the *Amazon EC2 Auto Scaling User Guide*.
    auto_rollback: ?bool = null,

    /// The amount of time, in seconds, to wait at the end of an instance refresh
    /// before the instance refresh is considered complete.
    bake_time: ?i32 = null,

    /// (Optional) The amount of time, in seconds, to wait after a checkpoint before
    /// continuing. This property is optional, but if you specify a value for it,
    /// you must also
    /// specify a value for `CheckpointPercentages`. If you specify a value for
    /// `CheckpointPercentages` and not for `CheckpointDelay`, the
    /// `CheckpointDelay` defaults to `3600` (1 hour).
    checkpoint_delay: ?i32 = null,

    /// (Optional) Threshold values for each checkpoint in ascending order. Each
    /// number must
    /// be unique. To replace all instances in the Auto Scaling group, the last
    /// number in the array must
    /// be `100`.
    ///
    /// For usage examples, see [Add checkpoints to an instance
    /// refresh](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-adding-checkpoints-instance-refresh.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    checkpoint_percentages: ?[]const i32 = null,

    /// A time period, in seconds, during which an instance refresh waits before
    /// moving on to
    /// replacing the next instance after a new instance enters the `InService`
    /// state.
    ///
    /// This property is not required for normal usage. Instead, use the
    /// `DefaultInstanceWarmup` property of the Auto Scaling group. The
    /// `InstanceWarmup` and `DefaultInstanceWarmup` properties work
    /// the same way. Only specify this property if you must override the
    /// `DefaultInstanceWarmup` property.
    ///
    /// If you do not specify this property, the instance warmup by default is the
    /// value of
    /// the `DefaultInstanceWarmup` property, if defined (which is recommended in
    /// all
    /// cases), or the `HealthCheckGracePeriod` property otherwise.
    instance_warmup: ?i32 = null,

    /// Specifies the maximum percentage of the group that can be in service and
    /// healthy, or
    /// pending, to support your workload when replacing instances. The value is
    /// expressed as a
    /// percentage of the desired capacity of the Auto Scaling group. Value range is
    /// 100 to 200.
    ///
    /// If you specify `MaxHealthyPercentage`, you must also specify
    /// `MinHealthyPercentage`, and the difference between them cannot be greater
    /// than 100. A larger range increases the number of instances that can be
    /// replaced at the
    /// same time.
    ///
    /// If you do not specify this property, the default is 100 percent, or the
    /// percentage set
    /// in the instance maintenance policy for the Auto Scaling group, if defined.
    max_healthy_percentage: ?i32 = null,

    /// Specifies the minimum percentage of the group to keep in service, healthy,
    /// and ready
    /// to use to support your workload to allow the operation to continue. The
    /// value is
    /// expressed as a percentage of the desired capacity of the Auto Scaling group.
    /// Value range is 0 to
    /// 100.
    ///
    /// If you do not specify this property, the default is 90 percent, or the
    /// percentage set
    /// in the instance maintenance policy for the Auto Scaling group, if defined.
    min_healthy_percentage: ?i32 = null,

    /// Choose the behavior that you want Amazon EC2 Auto Scaling to use if
    /// instances protected from scale in
    /// are found.
    ///
    /// The following lists the valid values:
    ///
    /// **Refresh**
    ///
    /// Amazon EC2 Auto Scaling replaces instances that are protected from scale in.
    ///
    /// **Ignore**
    ///
    /// Amazon EC2 Auto Scaling ignores instances that are protected from scale in
    /// and continues
    /// to replace instances that are not protected.
    ///
    /// **Wait (default)**
    ///
    /// Amazon EC2 Auto Scaling waits one hour for you to remove scale-in
    /// protection. Otherwise,
    /// the instance refresh will fail.
    scale_in_protected_instances: ?ScaleInProtectedInstances = null,

    /// (Optional) Indicates whether skip matching is enabled. If enabled (`true`),
    /// then Amazon EC2 Auto Scaling skips replacing instances that match the
    /// desired configuration. If no
    /// desired configuration is specified, then it skips replacing instances that
    /// have the same
    /// launch template and instance types that the Auto Scaling group was using
    /// before the start of the
    /// instance refresh. The default is `false`.
    ///
    /// For more information, see [Use an
    /// instance refresh with skip
    /// matching](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-instance-refresh-skip-matching.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    skip_matching: ?bool = null,

    /// Choose the behavior that you want Amazon EC2 Auto Scaling to use if
    /// instances in `Standby`
    /// state are found.
    ///
    /// The following lists the valid values:
    ///
    /// **Terminate**
    ///
    /// Amazon EC2 Auto Scaling terminates instances that are in `Standby`.
    ///
    /// **Ignore**
    ///
    /// Amazon EC2 Auto Scaling ignores instances that are in `Standby` and
    /// continues
    /// to replace instances that are in the `InService` state.
    ///
    /// **Wait (default)**
    ///
    /// Amazon EC2 Auto Scaling waits one hour for you to return the instances to
    /// service.
    /// Otherwise, the instance refresh will fail.
    standby_instances: ?StandbyInstances = null,
};
