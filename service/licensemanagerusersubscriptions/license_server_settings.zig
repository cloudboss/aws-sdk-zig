const ServerSettings = @import("server_settings.zig").ServerSettings;
const ServerType = @import("server_type.zig").ServerType;

/// The settings to configure your license server.
pub const LicenseServerSettings = struct {
    /// The `ServerSettings` resource contains the settings for your server.
    server_settings: ServerSettings,

    /// The type of license server.
    server_type: ServerType,

    pub const json_field_names = .{
        .server_settings = "ServerSettings",
        .server_type = "ServerType",
    };
};
