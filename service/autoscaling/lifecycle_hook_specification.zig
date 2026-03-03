/// Describes information used to specify a lifecycle hook for an Auto Scaling
/// group.
///
/// For more information, see [Amazon EC2 Auto Scaling lifecycle
/// hooks](https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html) in the *Amazon EC2 Auto Scaling User Guide*.
pub const LifecycleHookSpecification = struct {
    /// The action the Auto Scaling group takes when the lifecycle hook timeout
    /// elapses or if an
    /// unexpected failure occurs. The default value is `ABANDON`.
    ///
    /// Valid values: `CONTINUE` | `ABANDON`
    default_result: ?[]const u8 = null,

    /// The maximum time, in seconds, that can elapse before the lifecycle hook
    /// times out. The
    /// range is from `30` to `7200` seconds. The default value is
    /// `3600` seconds (1 hour).
    heartbeat_timeout: ?i32 = null,

    /// The name of the lifecycle hook.
    lifecycle_hook_name: []const u8,

    /// The lifecycle transition. For Auto Scaling groups, there are two major
    /// lifecycle
    /// transitions.
    ///
    /// * To create a lifecycle hook for scale-out events, specify
    /// `autoscaling:EC2_INSTANCE_LAUNCHING`.
    ///
    /// * To create a lifecycle hook for scale-in events, specify
    /// `autoscaling:EC2_INSTANCE_TERMINATING`.
    lifecycle_transition: []const u8,

    /// Additional information that you want to include any time Amazon EC2 Auto
    /// Scaling sends a message to
    /// the notification target.
    notification_metadata: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the notification target that Amazon EC2
    /// Auto Scaling sends
    /// notifications to when an instance is in a wait state for the lifecycle hook.
    /// You can
    /// specify an Amazon SNS topic or an Amazon SQS queue.
    notification_target_arn: ?[]const u8 = null,

    /// The ARN of the IAM role that allows the Auto Scaling group to publish to the
    /// specified
    /// notification target. For information about creating this role, see [Prepare
    /// to
    /// add a lifecycle hook to your Auto Scaling
    /// group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/prepare-for-lifecycle-notifications.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// Valid only if the notification target is an Amazon SNS topic or an Amazon
    /// SQS queue.
    role_arn: ?[]const u8 = null,
};
