const aws = @import("aws");

const BrandingConfiguration = @import("branding_configuration.zig").BrandingConfiguration;
const CookieSynchronizationConfiguration = @import("cookie_synchronization_configuration.zig").CookieSynchronizationConfiguration;
const EnabledType = @import("enabled_type.zig").EnabledType;
const ToolbarConfiguration = @import("toolbar_configuration.zig").ToolbarConfiguration;

/// A user settings resource that can be associated with a web portal. Once
/// associated with a web portal, user settings control how users can transfer
/// data between a streaming session and the their local devices.
pub const UserSettings = struct {
    /// The additional encryption context of the user settings.
    additional_encryption_context: ?[]const aws.map.StringMapEntry,

    /// A list of web portal ARNs that this user settings is associated with.
    associated_portal_arns: ?[]const []const u8,

    /// The branding configuration output that customizes the appearance of the web
    /// portal for end users.
    branding_configuration: ?BrandingConfiguration,

    /// The configuration that specifies which cookies should be synchronized from
    /// the end user's local browser to the remote browser.
    cookie_synchronization_configuration: ?CookieSynchronizationConfiguration,

    /// Specifies whether the user can copy text from the streaming session to the
    /// local device.
    copy_allowed: ?EnabledType,

    /// The customer managed key used to encrypt sensitive information in the user
    /// settings.
    customer_managed_key: ?[]const u8,

    /// Specifies whether the user can use deep links that open automatically when
    /// connecting to a session.
    deep_link_allowed: ?EnabledType,

    /// The amount of time that a streaming session remains active after users
    /// disconnect.
    disconnect_timeout_in_minutes: ?i32,

    /// Specifies whether the user can download files from the streaming session to
    /// the local device.
    download_allowed: ?EnabledType,

    /// The amount of time that users can be idle (inactive) before they are
    /// disconnected from their streaming session and the disconnect timeout
    /// interval begins.
    idle_disconnect_timeout_in_minutes: ?i32,

    /// Specifies whether the user can paste text from the local device to the
    /// streaming session.
    paste_allowed: ?EnabledType,

    /// Specifies whether the user can print to the local device.
    print_allowed: ?EnabledType,

    /// The configuration of the toolbar. This allows administrators to select the
    /// toolbar type and visual mode, set maximum display resolution for sessions,
    /// and choose which items are visible to end users during their sessions. If
    /// administrators do not modify these settings, end users retain control over
    /// their toolbar preferences.
    toolbar_configuration: ?ToolbarConfiguration,

    /// Specifies whether the user can upload files from the local device to the
    /// streaming session.
    upload_allowed: ?EnabledType,

    /// The ARN of the user settings.
    user_settings_arn: []const u8,

    /// Specifies whether the user can use WebAuthn redirection for passwordless
    /// login to websites within the streaming session.
    web_authn_allowed: ?EnabledType,

    pub const json_field_names = .{
        .additional_encryption_context = "additionalEncryptionContext",
        .associated_portal_arns = "associatedPortalArns",
        .branding_configuration = "brandingConfiguration",
        .cookie_synchronization_configuration = "cookieSynchronizationConfiguration",
        .copy_allowed = "copyAllowed",
        .customer_managed_key = "customerManagedKey",
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
