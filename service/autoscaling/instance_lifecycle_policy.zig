const RetentionTriggers = @import("retention_triggers.zig").RetentionTriggers;

/// The instance lifecycle policy for the Auto Scaling group. This policy
/// controls instance behavior when an instance
/// transitions through its lifecycle states. Configure retention triggers to
/// specify when instances should
/// move to a `Retained` state instead of automatic termination.
///
/// For more information, see
/// [
/// Control instance retention with instance lifecycle
/// policies](https://docs.aws.amazon.com/autoscaling/ec2/userguide/instance-lifecycle-policy.html)
/// in the *Amazon EC2 Auto Scaling User Guide*.
pub const InstanceLifecyclePolicy = struct {
    /// Specifies the conditions that trigger instance retention behavior. These
    /// triggers determine when instances
    /// should move to a `Retained` state instead of automatic termination. This
    /// allows you to maintain
    /// control over instance management when lifecycles transition and operations
    /// fail.
    retention_triggers: ?RetentionTriggers,
};
