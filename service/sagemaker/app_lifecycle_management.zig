const IdleSettings = @import("idle_settings.zig").IdleSettings;

/// Settings that are used to configure and manage the lifecycle of Amazon
/// SageMaker Studio applications.
pub const AppLifecycleManagement = struct {
    /// Settings related to idle shutdown of Studio applications.
    idle_settings: ?IdleSettings,

    pub const json_field_names = .{
        .idle_settings = "IdleSettings",
    };
};
