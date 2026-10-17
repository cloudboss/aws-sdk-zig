/// Identifies the Amazon EC2 Auto Scaling group that Image Builder takes the
/// build instance from,
/// and how long Image Builder waits when the group has no instance available.
pub const AutoScalingGroupConfiguration = struct {
    /// The number of seconds that Image Builder waits for an instance to become
    /// available in the
    /// group before the build fails. If you set this value to 0 or omit it, the
    /// build fails as
    /// soon as the group has no instance available.
    capacity_wait_timeout_seconds: ?i32 = null,

    /// The name of the Auto Scaling group, in the same account and Amazon Web
    /// Services Region as the
    /// infrastructure configuration. To specify a group, you must have permissions
    /// to describe
    /// it.
    name: []const u8,

    pub const json_field_names = .{
        .capacity_wait_timeout_seconds = "capacityWaitTimeoutSeconds",
        .name = "name",
    };
};
