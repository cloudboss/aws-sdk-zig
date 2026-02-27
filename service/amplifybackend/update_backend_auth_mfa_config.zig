const MFAMode = @import("mfa_mode.zig").MFAMode;
const Settings = @import("settings.zig").Settings;

/// Updates the multi-factor authentication (MFA) configuration for the backend
/// of your Amplify project.
pub const UpdateBackendAuthMFAConfig = struct {
    /// The MFA mode for the backend of your Amplify project.
    mfa_mode: ?MFAMode,

    /// The settings of your MFA configuration for the backend of your Amplify
    /// project.
    settings: ?Settings,

    pub const json_field_names = .{
        .mfa_mode = "MFAMode",
        .settings = "Settings",
    };
};
