const LaunchTemplateAutoRecoveryState = @import("launch_template_auto_recovery_state.zig").LaunchTemplateAutoRecoveryState;

/// The maintenance options of your instance.
pub const LaunchTemplateInstanceMaintenanceOptionsRequest = struct {
    /// Disables the automatic recovery behavior of your instance or sets it to
    /// default. For
    /// more information, see [Simplified automatic
    /// recovery](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-recover.html#instance-configuration-recovery).
    auto_recovery: ?LaunchTemplateAutoRecoveryState,
};
