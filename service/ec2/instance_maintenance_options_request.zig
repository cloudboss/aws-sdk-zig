const InstanceAutoRecoveryState = @import("instance_auto_recovery_state.zig").InstanceAutoRecoveryState;

/// The maintenance options for the instance.
pub const InstanceMaintenanceOptionsRequest = struct {
    /// Disables the automatic recovery behavior of your instance or sets it to
    /// default. For
    /// more information, see [Simplified automatic
    /// recovery](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-recover.html#instance-configuration-recovery).
    auto_recovery: ?InstanceAutoRecoveryState = null,
};
