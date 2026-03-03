/// Information about the configuration.
pub const HostedConfigurationVersionSummary = struct {
    /// The application ID.
    application_id: ?[]const u8 = null,

    /// The configuration profile ID.
    configuration_profile_id: ?[]const u8 = null,

    /// A standard MIME type describing the format of the configuration content. For
    /// more
    /// information, see
    /// [Content-Type](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17).
    content_type: ?[]const u8 = null,

    /// A description of the configuration.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name of the Key Management Service key that was used to
    /// encrypt this
    /// specific version of the configuration data in the AppConfig hosted
    /// configuration
    /// store.
    kms_key_arn: ?[]const u8 = null,

    /// A user-defined label for an AppConfig hosted configuration version.
    version_label: ?[]const u8 = null,

    /// The configuration version.
    version_number: i32 = 0,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .configuration_profile_id = "ConfigurationProfileId",
        .content_type = "ContentType",
        .description = "Description",
        .kms_key_arn = "KmsKeyArn",
        .version_label = "VersionLabel",
        .version_number = "VersionNumber",
    };
};
