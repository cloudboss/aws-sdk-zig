const StaticKeySettings = @import("static_key_settings.zig").StaticKeySettings;

/// Key Provider Settings
pub const KeyProviderSettings = struct {
    static_key_settings: ?StaticKeySettings,

    pub const json_field_names = .{
        .static_key_settings = "StaticKeySettings",
    };
};
