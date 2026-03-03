/// Describes a lifecycle hook. A lifecycle hook lets you create solutions that
/// are aware
/// of events in the Auto Scaling instance lifecycle, and then perform a custom
/// action on instances
/// when the corresponding lifecycle event
/// occurs.
pub const LifecycleHook = struct {
    /// The name of the Auto Scaling group for the lifecycle hook.
    auto_scaling_group_name: ?[]const u8 = null,

    /// The action the Auto Scaling group takes when the lifecycle hook timeout
    /// elapses or if an
    /// unexpected failure occurs.
    ///
    /// Valid values: `CONTINUE` | `ABANDON`
    default_result: ?[]const u8 = null,

    /// The maximum time, in seconds, that an instance can remain in a wait state.
    /// The maximum
    /// is 172800 seconds (48 hours) or 100 times `HeartbeatTimeout`, whichever is
    /// smaller.
    global_timeout: ?i32 = null,

    /// The maximum time, in seconds, that can elapse before the lifecycle hook
    /// times out. If
    /// the lifecycle hook times out, Amazon EC2 Auto Scaling performs the action
    /// that you specified in the
    /// `DefaultResult` property.
    heartbeat_timeout: ?i32 = null,

    /// The name of the lifecycle hook.
    lifecycle_hook_name: ?[]const u8 = null,

    /// The lifecycle transition.
    ///
    /// Valid values: `autoscaling:EC2_INSTANCE_LAUNCHING` |
    /// `autoscaling:EC2_INSTANCE_TERMINATING`
    lifecycle_transition: ?[]const u8 = null,

    /// Additional information that is included any time Amazon EC2 Auto Scaling
    /// sends a message to the
    /// notification target.
    notification_metadata: ?[]const u8 = null,

    /// The ARN of the target that Amazon EC2 Auto Scaling sends notifications to
    /// when an instance is in a
    /// wait state for the lifecycle hook.
    notification_target_arn: ?[]const u8 = null,

    /// The ARN of the IAM role that allows the Auto Scaling group to publish to the
    /// specified
    /// notification target (an Amazon SNS topic or an Amazon SQS queue).
    role_arn: ?[]const u8 = null,
};
