const aws = @import("aws");

const WebContentFilteringPolicy = @import("web_content_filtering_policy.zig").WebContentFilteringPolicy;

/// The browser settings resource that can be associated with a web portal. Once
/// associated with a web portal, browser settings control how the browser will
/// behave once a user starts a streaming session for the web portal.
pub const BrowserSettings = struct {
    /// The additional encryption context of the browser settings.
    additional_encryption_context: ?[]const aws.map.StringMapEntry,

    /// A list of web portal ARNs that this browser settings is associated with.
    associated_portal_arns: ?[]const []const u8,

    /// A JSON string containing Chrome Enterprise policies that will be applied to
    /// all streaming sessions.
    browser_policy: ?[]const u8,

    /// The ARN of the browser settings.
    browser_settings_arn: []const u8,

    /// The customer managed key used to encrypt sensitive information in the
    /// browser settings.
    customer_managed_key: ?[]const u8,

    /// The policy that specifies which URLs end users are allowed to access or
    /// which URLs or domain categories they are restricted from accessing for
    /// enhanced security.
    web_content_filtering_policy: ?WebContentFilteringPolicy,

    pub const json_field_names = .{
        .additional_encryption_context = "additionalEncryptionContext",
        .associated_portal_arns = "associatedPortalArns",
        .browser_policy = "browserPolicy",
        .browser_settings_arn = "browserSettingsArn",
        .customer_managed_key = "customerManagedKey",
        .web_content_filtering_policy = "webContentFilteringPolicy",
    };
};
