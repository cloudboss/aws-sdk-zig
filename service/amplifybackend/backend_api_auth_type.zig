const Mode = @import("mode.zig").Mode;
const BackendAPIAppSyncAuthSettings = @import("backend_api_app_sync_auth_settings.zig").BackendAPIAppSyncAuthSettings;

/// Describes the auth types for your configured data models.
pub const BackendAPIAuthType = struct {
    /// Describes the authentication mode.
    mode: ?Mode,

    /// Describes settings for the authentication mode.
    settings: ?BackendAPIAppSyncAuthSettings,

    pub const json_field_names = .{
        .mode = "Mode",
        .settings = "Settings",
    };
};
