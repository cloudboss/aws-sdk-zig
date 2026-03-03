const MFAMode = @import("mfa_mode.zig").MFAMode;
const Settings = @import("settings.zig").Settings;

/// Describes whether to apply multi-factor authentication policies for your
/// Amazon Cognito user pool configured as a part of your Amplify project.
pub const CreateBackendAuthMFAConfig = struct {
    /// Describes whether MFA should be [ON, OFF, or OPTIONAL] for authentication in
    /// your Amplify project.
    mfa_mode: MFAMode,

    /// Describes the configuration settings and methods for your Amplify app users
    /// to use MFA.
    settings: ?Settings = null,

    pub const json_field_names = .{
        .mfa_mode = "MFAMode",
        .settings = "Settings",
    };
};
