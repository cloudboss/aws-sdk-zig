const InstanceHealthState = @import("instance_health_state.zig").InstanceHealthState;
const InstanceHealthReason = @import("instance_health_reason.zig").InstanceHealthReason;

/// Describes information about the health of the instance.
pub const InstanceHealthSummary = struct {
    /// Describes the overall instance health. Valid values are below.
    instance_health: ?InstanceHealthState = null,

    /// More information about the instance health. If the `instanceHealth` is
    /// `healthy`, then an `instanceHealthReason` value is not
    /// provided.
    ///
    /// If **
    /// `instanceHealth`
    /// ** is `initial`,
    /// the **
    /// `instanceHealthReason`
    /// ** value can be one of the
    /// following:
    ///
    /// * **
    /// `Lb.RegistrationInProgress`
    /// ** - The target
    /// instance is in the process of being registered with the load balancer.
    ///
    /// * **
    /// `Lb.InitialHealthChecking`
    /// ** - The
    /// Lightsail load balancer is still sending the target instance the minimum
    /// number of
    /// health checks required to determine its health status.
    ///
    /// If **
    /// `instanceHealth`
    /// ** is `unhealthy`,
    /// the **
    /// `instanceHealthReason`
    /// ** value can be one of the
    /// following:
    ///
    /// * **
    /// `Instance.ResponseCodeMismatch`
    /// ** - The
    /// health checks did not return an expected HTTP code.
    ///
    /// * **
    /// `Instance.Timeout`
    /// ** - The health check
    /// requests timed out.
    ///
    /// * **
    /// `Instance.FailedHealthChecks`
    /// ** - The health
    /// checks failed because the connection to the target instance timed out, the
    /// target instance
    /// response was malformed, or the target instance failed the health check for
    /// an unknown
    /// reason.
    ///
    /// * **
    /// `Lb.InternalError`
    /// ** - The health checks
    /// failed due to an internal error.
    ///
    /// If **
    /// `instanceHealth`
    /// ** is `unused`,
    /// the **
    /// `instanceHealthReason`
    /// ** value can be one of the
    /// following:
    ///
    /// * **
    /// `Instance.NotRegistered`
    /// ** - The target
    /// instance is not registered with the target group.
    ///
    /// * **
    /// `Instance.NotInUse`
    /// ** - The target group is
    /// not used by any load balancer, or the target instance is in an Availability
    /// Zone that is
    /// not enabled for its load balancer.
    ///
    /// * **
    /// `Instance.IpUnusable`
    /// ** - The target IP
    /// address is reserved for use by a Lightsail load balancer.
    ///
    /// * **
    /// `Instance.InvalidState`
    /// ** - The target is in
    /// the stopped or terminated state.
    ///
    /// If **
    /// `instanceHealth`
    /// ** is `draining`,
    /// the **
    /// `instanceHealthReason`
    /// ** value can be one of the
    /// following:
    ///
    /// * **
    /// `Instance.DeregistrationInProgress`
    /// ** - The
    /// target instance is in the process of being deregistered and the
    /// deregistration delay
    /// period has not expired.
    instance_health_reason: ?InstanceHealthReason = null,

    /// The name of the Lightsail instance for which you are requesting health check
    /// data.
    instance_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_health = "instanceHealth",
        .instance_health_reason = "instanceHealthReason",
        .instance_name = "instanceName",
    };
};
