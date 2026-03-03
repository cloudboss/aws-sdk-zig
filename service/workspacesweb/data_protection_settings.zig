const aws = @import("aws");

const InlineRedactionConfiguration = @import("inline_redaction_configuration.zig").InlineRedactionConfiguration;

/// The data protection settings resource that can be associated with a web
/// portal.
pub const DataProtectionSettings = struct {
    /// The additional encryption context of the data protection settings.
    additional_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// A list of web portal ARNs that this data protection settings resource is
    /// associated with.
    associated_portal_arns: ?[]const []const u8 = null,

    /// The creation date timestamp of the data protection settings.
    creation_date: ?i64 = null,

    /// The customer managed key used to encrypt sensitive information in the data
    /// protection settings.
    customer_managed_key: ?[]const u8 = null,

    /// The ARN of the data protection settings resource.
    data_protection_settings_arn: []const u8,

    /// The description of the data protection settings.
    description: ?[]const u8 = null,

    /// The display name of the data protection settings.
    display_name: ?[]const u8 = null,

    /// The inline redaction configuration for the data protection settings.
    inline_redaction_configuration: ?InlineRedactionConfiguration = null,

    pub const json_field_names = .{
        .additional_encryption_context = "additionalEncryptionContext",
        .associated_portal_arns = "associatedPortalArns",
        .creation_date = "creationDate",
        .customer_managed_key = "customerManagedKey",
        .data_protection_settings_arn = "dataProtectionSettingsArn",
        .description = "description",
        .display_name = "displayName",
        .inline_redaction_configuration = "inlineRedactionConfiguration",
    };
};
