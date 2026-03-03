const AutoRecoveryEnum = @import("auto_recovery_enum.zig").AutoRecoveryEnum;

/// Configures automatic maintenance settings for WorkSpace Instance.
pub const InstanceMaintenanceOptionsRequest = struct {
    /// Enables or disables automatic instance recovery.
    auto_recovery: ?AutoRecoveryEnum = null,

    pub const json_field_names = .{
        .auto_recovery = "AutoRecovery",
    };
};
