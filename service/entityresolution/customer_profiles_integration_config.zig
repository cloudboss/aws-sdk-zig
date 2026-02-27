/// Specifies the configuration for integrating with Customer Profiles. This
/// configuration enables Entity Resolution to send matched output directly to
/// Customer Profiles instead of Amazon S3, creating a unified customer view by
/// automatically updating customer profiles based on match clusters.
pub const CustomerProfilesIntegrationConfig = struct {
    /// The Amazon Resource Name (ARN) of the Customer Profiles domain where the
    /// matched output will be sent.
    domain_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the Customer Profiles object type that
    /// defines the structure for the matched customer data.
    object_type_arn: []const u8,

    pub const json_field_names = .{
        .domain_arn = "domainArn",
        .object_type_arn = "objectTypeArn",
    };
};
