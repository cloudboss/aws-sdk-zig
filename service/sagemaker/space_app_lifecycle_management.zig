const SpaceIdleSettings = @import("space_idle_settings.zig").SpaceIdleSettings;

/// Settings that are used to configure and manage the lifecycle of Amazon
/// SageMaker Studio applications in a space.
pub const SpaceAppLifecycleManagement = struct {
    /// Settings related to idle shutdown of Studio applications.
    idle_settings: ?SpaceIdleSettings = null,

    pub const json_field_names = .{
        .idle_settings = "IdleSettings",
    };
};
