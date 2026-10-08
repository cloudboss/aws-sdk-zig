/// Contains summary information about an application.
pub const ApplicationSummary = struct {
    /// The unique identifier of the application.
    application_id: []const u8,

    /// The name of the application.
    application_name: []const u8,

    /// The identifier of the default AWS KMS key used to encrypt data for the
    /// application.
    default_kms_key_id: ?[]const u8 = null,

    /// The domain associated with the application.
    domain: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .application_name = "applicationName",
        .default_kms_key_id = "defaultKmsKeyId",
        .domain = "domain",
    };
};
