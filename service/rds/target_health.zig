const TargetHealthReason = @import("target_health_reason.zig").TargetHealthReason;
const TargetState = @import("target_state.zig").TargetState;

/// Information about the connection health of an RDS Proxy target.
pub const TargetHealth = struct {
    /// A description of the health of the RDS Proxy target. If the `State` is
    /// `AVAILABLE`, a description is not included.
    description: ?[]const u8 = null,

    /// The reason for the current health `State` of the RDS Proxy target.
    reason: ?TargetHealthReason = null,

    /// The current state of the connection health lifecycle for the RDS Proxy
    /// target. The following is a typical lifecycle example for the states of an
    /// RDS Proxy target:
    ///
    /// `registering` > `unavailable` > `available` > `unavailable` > `available`
    state: ?TargetState = null,
};
