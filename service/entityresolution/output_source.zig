const CustomerProfilesIntegrationConfig = @import("customer_profiles_integration_config.zig").CustomerProfilesIntegrationConfig;
const OutputAttribute = @import("output_attribute.zig").OutputAttribute;

/// A list of `OutputAttribute` objects, each of which have the fields `Name`
/// and `Hashed`. Each of these objects selects a column to be included in the
/// output table, and whether the values of the column should be hashed.
pub const OutputSource = struct {
    /// Normalizes the attributes defined in the schema in the input data. For
    /// example, if an attribute has an `AttributeType` of `PHONE_NUMBER`, and the
    /// data in the input table is in a format of 1234567890, Entity Resolution will
    /// normalize this field in the output to (123)-456-7890.
    apply_normalization: ?bool = null,

    /// Specifies the Customer Profiles integration configuration for sending
    /// matched output directly to Customer Profiles. When configured, Entity
    /// Resolution automatically creates and updates customer profiles based on
    /// match clusters, eliminating the need for manual Amazon S3 integration setup.
    customer_profiles_integration_config: ?CustomerProfilesIntegrationConfig = null,

    /// Customer KMS ARN for encryption at rest. If not provided, system will use an
    /// Entity Resolution managed KMS key.
    kms_arn: ?[]const u8 = null,

    /// A list of `OutputAttribute` objects, each of which have the fields `Name`
    /// and `Hashed`. Each of these objects selects a column to be included in the
    /// output table, and whether the values of the column should be hashed.
    output: []const OutputAttribute,

    /// The S3 path to which Entity Resolution will write the output table.
    output_s3_path: []const u8 = "",

    pub const json_field_names = .{
        .apply_normalization = "applyNormalization",
        .customer_profiles_integration_config = "customerProfilesIntegrationConfig",
        .kms_arn = "KMSArn",
        .output = "output",
        .output_s3_path = "outputS3Path",
    };
};
