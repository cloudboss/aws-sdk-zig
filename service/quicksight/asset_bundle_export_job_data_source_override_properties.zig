const AssetBundleExportJobDataSourcePropertyToOverride = @import("asset_bundle_export_job_data_source_property_to_override.zig").AssetBundleExportJobDataSourcePropertyToOverride;

/// Controls how a specific `DataSource` resource is parameterized in the
/// returned CloudFormation template.
pub const AssetBundleExportJobDataSourceOverrideProperties = struct {
    /// The ARN of the specific `DataSource` resource whose override properties are
    /// configured in this structure.
    arn: []const u8,

    /// A list of `DataSource` resource properties to generate variables for in the
    /// returned CloudFormation template.
    properties: []const AssetBundleExportJobDataSourcePropertyToOverride,

    pub const json_field_names = .{
        .arn = "Arn",
        .properties = "Properties",
    };
};
