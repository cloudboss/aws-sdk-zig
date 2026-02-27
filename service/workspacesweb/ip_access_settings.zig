const aws = @import("aws");

const IpRule = @import("ip_rule.zig").IpRule;

/// The IP access settings resource that can be associated with a web portal.
pub const IpAccessSettings = struct {
    /// The additional encryption context of the IP access settings.
    additional_encryption_context: ?[]const aws.map.StringMapEntry,

    /// A list of web portal ARNs that this IP access settings resource is
    /// associated with.
    associated_portal_arns: ?[]const []const u8,

    /// The creation date timestamp of the IP access settings.
    creation_date: ?i64,

    /// The customer managed key used to encrypt sensitive information in the IP
    /// access settings.
    customer_managed_key: ?[]const u8,

    /// The description of the IP access settings.
    description: ?[]const u8,

    /// The display name of the IP access settings.
    display_name: ?[]const u8,

    /// The ARN of the IP access settings resource.
    ip_access_settings_arn: []const u8,

    /// The IP rules of the IP access settings.
    ip_rules: ?[]const IpRule,

    pub const json_field_names = .{
        .additional_encryption_context = "additionalEncryptionContext",
        .associated_portal_arns = "associatedPortalArns",
        .creation_date = "creationDate",
        .customer_managed_key = "customerManagedKey",
        .description = "description",
        .display_name = "displayName",
        .ip_access_settings_arn = "ipAccessSettingsArn",
        .ip_rules = "ipRules",
    };
};
