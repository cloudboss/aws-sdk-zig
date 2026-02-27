const TargetHealthReasonEnum = @import("target_health_reason_enum.zig").TargetHealthReasonEnum;
const TargetHealthStateEnum = @import("target_health_state_enum.zig").TargetHealthStateEnum;

/// Information about the current health of a target.
pub const TargetHealth = struct {
    /// A description of the target health that provides additional details. If the
    /// state is
    /// `healthy`, a description is not provided.
    description: ?[]const u8,

    /// The reason code.
    ///
    /// If the target state is `healthy`, a reason code is not provided.
    ///
    /// If the target state is `initial`, the reason code can be one of the
    /// following
    /// values:
    ///
    /// * `Elb.RegistrationInProgress` - The target is in the process of being
    ///   registered
    /// with the load balancer.
    ///
    /// * `Elb.InitialHealthChecking` - The load balancer is still sending the
    ///   target the
    /// minimum number of health checks required to determine its health status.
    ///
    /// If the target state is `unhealthy`, the reason code can be one of the
    /// following
    /// values:
    ///
    /// * `Target.ResponseCodeMismatch` - The health checks did not return an
    /// expected HTTP code.
    ///
    /// * `Target.Timeout` - The health check requests timed out.
    ///
    /// * `Target.FailedHealthChecks` - The load balancer received an error while
    /// establishing a connection to the target or the target response was
    /// malformed.
    ///
    /// * `Elb.InternalError` - The health checks failed due to an internal error.
    ///
    /// If the target state is `unused`, the reason code can be one of the following
    /// values:
    ///
    /// * `Target.NotRegistered` - The target is not registered with the target
    /// group.
    ///
    /// * `Target.NotInUse` - The target group is not used by any load balancer or
    /// the target is in an Availability Zone that is not enabled for its load
    /// balancer.
    ///
    /// * `Target.InvalidState` - The target is in the stopped or terminated
    /// state.
    ///
    /// * `Target.IpUnusable` - The target IP address is reserved for use by a load
    /// balancer.
    ///
    /// If the target state is `draining`, the reason code can be the following
    /// value:
    ///
    /// * `Target.DeregistrationInProgress` - The target is in the process of being
    /// deregistered and the deregistration delay period has not expired.
    ///
    /// If the target state is `unavailable`, the reason code can be the following
    /// value:
    ///
    /// * `Target.HealthCheckDisabled` - Health checks are disabled for the target
    /// group.
    ///
    /// * `Elb.InternalError` - Target health is unavailable due to an internal
    /// error.
    reason: ?TargetHealthReasonEnum,

    /// The state of the target.
    state: ?TargetHealthStateEnum,
};
