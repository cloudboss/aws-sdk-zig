const DecalSettings = @import("decal_settings.zig").DecalSettings;

/// Decal settings configuration for a column
pub const DecalSettingsConfiguration = struct {
    /// A list of up to 50 decal settings.
    custom_decal_settings: ?[]const DecalSettings,

    pub const json_field_names = .{
        .custom_decal_settings = "CustomDecalSettings",
    };
};
