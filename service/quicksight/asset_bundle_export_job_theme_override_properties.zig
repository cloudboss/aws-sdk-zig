const AssetBundleExportJobThemePropertyToOverride = @import("asset_bundle_export_job_theme_property_to_override.zig").AssetBundleExportJobThemePropertyToOverride;

/// Controls how a specific `Theme` resource is parameterized in the returned
/// CloudFormation template.
pub const AssetBundleExportJobThemeOverrideProperties = struct {
    /// The ARN of the specific `Theme` resource whose override properties are
    /// configured in this structure.
    arn: []const u8,

    /// A list of `Theme` resource properties to generate variables for in the
    /// returned CloudFormation template.
    properties: []const AssetBundleExportJobThemePropertyToOverride,

    pub const json_field_names = .{
        .arn = "Arn",
        .properties = "Properties",
    };
};
