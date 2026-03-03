/// Resource capacity settings. Fleet capacity is measured in Amazon EC2
/// instances. Pending and
/// terminating counts are non-zero when the fleet capacity is adjusting to a
/// scaling event
/// or if access to resources is temporarily affected.
pub const EC2InstanceCounts = struct {
    /// Actual number of instances that are ready to host game sessions.
    active: ?i32 = null,

    /// Requested number of active instances. Amazon GameLift Servers takes action
    /// as needed to maintain the
    /// desired number of instances. Capacity is scaled up or down by changing the
    /// desired
    /// instances. A change in the desired instances value can take up to 1 minute
    /// to be
    /// reflected when viewing a fleet's capacity settings.
    desired: ?i32 = null,

    /// Number of active instances that are not currently hosting a game session.
    idle: ?i32 = null,

    /// The maximum instance count value allowed.
    maximum: ?i32 = null,

    /// The minimum instance count value allowed.
    minimum: ?i32 = null,

    /// Number of instances that are starting but not yet active.
    pending: ?i32 = null,

    /// Number of instances that are no longer active but haven't yet been
    /// terminated.
    terminating: ?i32 = null,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .desired = "DESIRED",
        .idle = "IDLE",
        .maximum = "MAXIMUM",
        .minimum = "MINIMUM",
        .pending = "PENDING",
        .terminating = "TERMINATING",
    };
};
