const AssetBundleExportJobAnalysisPropertyToOverride = @import("asset_bundle_export_job_analysis_property_to_override.zig").AssetBundleExportJobAnalysisPropertyToOverride;

/// Controls how a specific `Analysis` resource is parameterized in the returned
/// CloudFormation template.
pub const AssetBundleExportJobAnalysisOverrideProperties = struct {
    /// The ARN of the specific `Analysis` resource whose override properties are
    /// configured in this structure.
    arn: []const u8,

    /// A list of `Analysis` resource properties to generate variables for in the
    /// returned CloudFormation template.
    properties: []const AssetBundleExportJobAnalysisPropertyToOverride,

    pub const json_field_names = .{
        .arn = "Arn",
        .properties = "Properties",
    };
};
