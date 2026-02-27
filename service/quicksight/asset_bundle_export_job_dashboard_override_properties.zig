const AssetBundleExportJobDashboardPropertyToOverride = @import("asset_bundle_export_job_dashboard_property_to_override.zig").AssetBundleExportJobDashboardPropertyToOverride;

/// Controls how a specific `Dashboard` resource is parameterized in the
/// returned
/// CloudFormation template.
pub const AssetBundleExportJobDashboardOverrideProperties = struct {
    /// The ARN of the specific `Dashboard` resource whose override properties are
    /// configured in this structure.
    arn: []const u8,

    /// A list of `Dashboard` resource properties to generate variables for in the
    /// returned CloudFormation template.
    properties: []const AssetBundleExportJobDashboardPropertyToOverride,

    pub const json_field_names = .{
        .arn = "Arn",
        .properties = "Properties",
    };
};
