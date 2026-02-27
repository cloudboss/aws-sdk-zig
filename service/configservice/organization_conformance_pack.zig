const ConformancePackInputParameter = @import("conformance_pack_input_parameter.zig").ConformancePackInputParameter;

/// An organization conformance pack that has information about conformance
/// packs that Config creates in member accounts.
pub const OrganizationConformancePack = struct {
    /// A list of `ConformancePackInputParameter` objects.
    conformance_pack_input_parameters: ?[]const ConformancePackInputParameter,

    /// The name of the Amazon S3 bucket where Config stores conformance pack
    /// templates.
    ///
    /// This field is optional.
    delivery_s3_bucket: ?[]const u8,

    /// Any folder structure you want to add to an Amazon S3 bucket.
    ///
    /// This field is optional.
    delivery_s3_key_prefix: ?[]const u8,

    /// A comma-separated list of accounts excluded from organization conformance
    /// pack.
    excluded_accounts: ?[]const []const u8,

    /// Last time when organization conformation pack was updated.
    last_update_time: i64,

    /// Amazon Resource Name (ARN) of organization conformance pack.
    organization_conformance_pack_arn: []const u8,

    /// The name you assign to an organization conformance pack.
    organization_conformance_pack_name: []const u8,

    pub const json_field_names = .{
        .conformance_pack_input_parameters = "ConformancePackInputParameters",
        .delivery_s3_bucket = "DeliveryS3Bucket",
        .delivery_s3_key_prefix = "DeliveryS3KeyPrefix",
        .excluded_accounts = "ExcludedAccounts",
        .last_update_time = "LastUpdateTime",
        .organization_conformance_pack_arn = "OrganizationConformancePackArn",
        .organization_conformance_pack_name = "OrganizationConformancePackName",
    };
};
