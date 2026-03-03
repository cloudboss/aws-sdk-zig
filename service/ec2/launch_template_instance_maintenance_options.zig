const LaunchTemplateAutoRecoveryState = @import("launch_template_auto_recovery_state.zig").LaunchTemplateAutoRecoveryState;

/// The maintenance options of your instance.
pub const LaunchTemplateInstanceMaintenanceOptions = struct {
    /// Disables the automatic recovery behavior of your instance or sets it to
    /// default.
    auto_recovery: ?LaunchTemplateAutoRecoveryState = null,
};
