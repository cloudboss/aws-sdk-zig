const AssetBundleExportJobDataSetPropertyToOverride = @import("asset_bundle_export_job_data_set_property_to_override.zig").AssetBundleExportJobDataSetPropertyToOverride;

/// Controls how a specific `DataSet` resource is parameterized in the returned
/// CloudFormation template.
pub const AssetBundleExportJobDataSetOverrideProperties = struct {
    /// The ARN of the specific `DataSet` resource whose override properties are
    /// configured in this structure.
    arn: []const u8,

    /// A list of `DataSet` resource properties to generate variables for in the
    /// returned CloudFormation template.
    properties: []const AssetBundleExportJobDataSetPropertyToOverride,

    pub const json_field_names = .{
        .arn = "Arn",
        .properties = "Properties",
    };
};
