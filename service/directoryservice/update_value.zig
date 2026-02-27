const OSUpdateSettings = @import("os_update_settings.zig").OSUpdateSettings;

/// The value for a given type of `UpdateSettings`.
pub const UpdateValue = struct {
    /// The OS update related settings.
    os_update_settings: ?OSUpdateSettings,

    pub const json_field_names = .{
        .os_update_settings = "OSUpdateSettings",
    };
};
