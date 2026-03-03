const RetentionAction = @import("retention_action.zig").RetentionAction;

/// Defines the specific triggers that cause instances to be retained in a
/// Retained state rather than terminated. Each trigger corresponds to a
/// different failure scenario during the instance lifecycle. This allows
/// fine-grained control over when to preserve instances for manual
/// intervention.
pub const RetentionTriggers = struct {
    /// Specifies the action when a termination lifecycle hook is abandoned due to
    /// failure, timeout, or explicit abandonment (calling CompleteLifecycleAction).
    ///
    /// Set to `retain` to move instances to a retained state. Set to `terminate`
    /// for default termination behavior.
    ///
    /// Retained instances don't count toward desired capacity and remain until you
    /// call `TerminateInstanceInAutoScalingGroup`.
    terminate_hook_abandon: ?RetentionAction = null,
};
