const BrandingConfiguration = @import("branding_configuration.zig").BrandingConfiguration;
const CookieSynchronizationConfiguration = @import("cookie_synchronization_configuration.zig").CookieSynchronizationConfiguration;
const EnabledType = @import("enabled_type.zig").EnabledType;
const ToolbarConfiguration = @import("toolbar_configuration.zig").ToolbarConfiguration;

/// The summary of user settings.
pub const UserSettingsSummary = struct {
    /// The branding configuration output that customizes the appearance of the web
    /// portal for end users.
    branding_configuration: ?BrandingConfiguration = null,

    /// The configuration that specifies which cookies should be synchronized from
    /// the end user's local browser to the remote browser.
    cookie_synchronization_configuration: ?CookieSynchronizationConfiguration = null,

    /// Specifies whether the user can copy text from the streaming session to the
    /// local device.
    copy_allowed: ?EnabledType = null,

    /// Specifies whether the user can use deep links that open automatically when
    /// connecting to a session.
    deep_link_allowed: ?EnabledType = null,

    /// The amount of time that a streaming session remains active after users
    /// disconnect.
    disconnect_timeout_in_minutes: ?i32 = null,

    /// Specifies whether the user can download files from the streaming session to
    /// the local device.
    download_allowed: ?EnabledType = null,

    /// The amount of time that users can be idle (inactive) before they are
    /// disconnected from their streaming session and the disconnect timeout
    /// interval begins.
    idle_disconnect_timeout_in_minutes: ?i32 = null,

    /// Specifies whether the user can paste text from the local device to the
    /// streaming session.
    paste_allowed: ?EnabledType = null,

    /// Specifies whether the user can print to the local device.
    print_allowed: ?EnabledType = null,

    /// The configuration of the toolbar. This allows administrators to select the
    /// toolbar type and visual mode, set maximum display resolution for sessions,
    /// and choose which items are visible to end users during their sessions. If
    /// administrators do not modify these settings, end users retain control over
    /// their toolbar preferences.
    toolbar_configuration: ?ToolbarConfiguration = null,

    /// Specifies whether the user can upload files from the local device to the
    /// streaming session.
    upload_allowed: ?EnabledType = null,

    /// The ARN of the user settings.
    user_settings_arn: []const u8,

    /// Specifies whether the user can use WebAuthn redirection for passwordless
    /// login to websites within the streaming session.
    web_authn_allowed: ?EnabledType = null,

    pub const json_field_names = .{
        .branding_configuration = "brandingConfiguration",
        .cookie_synchronization_configuration = "cookieSynchronizationConfiguration",
        .copy_allowed = "copyAllowed",
        .deep_link_allowed = "deepLinkAllowed",
        .disconnect_timeout_in_minutes = "disconnectTimeoutInMinutes",
        .download_allowed = "downloadAllowed",
        .idle_disconnect_timeout_in_minutes = "idleDisconnectTimeoutInMinutes",
        .paste_allowed = "pasteAllowed",
        .print_allowed = "printAllowed",
        .toolbar_configuration = "toolbarConfiguration",
        .upload_allowed = "uploadAllowed",
        .user_settings_arn = "userSettingsArn",
        .web_authn_allowed = "webAuthnAllowed",
    };
};
