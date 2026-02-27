const aws = @import("aws");

const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const BrowserType = @import("browser_type.zig").BrowserType;
const InstanceType = @import("instance_type.zig").InstanceType;
const PortalStatus = @import("portal_status.zig").PortalStatus;
const RendererType = @import("renderer_type.zig").RendererType;

/// The web portal.
pub const Portal = struct {
    /// The additional encryption context of the portal.
    additional_encryption_context: ?[]const aws.map.StringMapEntry,

    /// The type of authentication integration points used when signing into the web
    /// portal. Defaults to `Standard`.
    ///
    /// `Standard` web portals are authenticated directly through your identity
    /// provider. You need to call `CreateIdentityProvider` to integrate your
    /// identity provider with your web portal. User and group access to your web
    /// portal is controlled through your identity provider.
    ///
    /// `IAM Identity Center` web portals are authenticated through IAM Identity
    /// Center. Identity sources (including external identity provider integration),
    /// plus user and group access to your web portal, can be configured in the IAM
    /// Identity Center.
    authentication_type: ?AuthenticationType,

    /// The ARN of the browser settings that is associated with this web portal.
    browser_settings_arn: ?[]const u8,

    /// The browser that users see when using a streaming session.
    browser_type: ?BrowserType,

    /// The creation date of the web portal.
    creation_date: ?i64,

    /// The customer managed key used to encrypt sensitive information in the
    /// portal.
    customer_managed_key: ?[]const u8,

    /// The ARN of the data protection settings.
    data_protection_settings_arn: ?[]const u8,

    /// The name of the web portal.
    display_name: ?[]const u8,

    /// The type and resources of the underlying instance.
    instance_type: ?InstanceType,

    /// The ARN of the IP access settings.
    ip_access_settings_arn: ?[]const u8,

    /// The maximum number of concurrent sessions for the portal.
    max_concurrent_sessions: ?i32,

    /// The ARN of the network settings that is associated with the web portal.
    network_settings_arn: ?[]const u8,

    /// The ARN of the web portal.
    portal_arn: []const u8,

    /// The custom domain of the web portal that users access in order to start
    /// streaming sessions.
    portal_custom_domain: ?[]const u8,

    /// The endpoint URL of the web portal that users access in order to start
    /// streaming sessions.
    portal_endpoint: ?[]const u8,

    /// The status of the web portal.
    portal_status: ?PortalStatus,

    /// The renderer that is used in streaming sessions.
    renderer_type: ?RendererType,

    /// The ARN of the session logger that is assocaited with the portal.
    session_logger_arn: ?[]const u8,

    /// A message that explains why the web portal is in its current status.
    status_reason: ?[]const u8,

    /// The ARN of the trust store that is associated with the web portal.
    trust_store_arn: ?[]const u8,

    /// The ARN of the user access logging settings that is associated with the web
    /// portal.
    user_access_logging_settings_arn: ?[]const u8,

    /// The ARN of the user settings that is associated with the web portal.
    user_settings_arn: ?[]const u8,

    pub const json_field_names = .{
        .additional_encryption_context = "additionalEncryptionContext",
        .authentication_type = "authenticationType",
        .browser_settings_arn = "browserSettingsArn",
        .browser_type = "browserType",
        .creation_date = "creationDate",
        .customer_managed_key = "customerManagedKey",
        .data_protection_settings_arn = "dataProtectionSettingsArn",
        .display_name = "displayName",
        .instance_type = "instanceType",
        .ip_access_settings_arn = "ipAccessSettingsArn",
        .max_concurrent_sessions = "maxConcurrentSessions",
        .network_settings_arn = "networkSettingsArn",
        .portal_arn = "portalArn",
        .portal_custom_domain = "portalCustomDomain",
        .portal_endpoint = "portalEndpoint",
        .portal_status = "portalStatus",
        .renderer_type = "rendererType",
        .session_logger_arn = "sessionLoggerArn",
        .status_reason = "statusReason",
        .trust_store_arn = "trustStoreArn",
        .user_access_logging_settings_arn = "userAccessLoggingSettingsArn",
        .user_settings_arn = "userSettingsArn",
    };
};
