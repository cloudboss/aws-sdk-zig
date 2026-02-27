const AssetBundleExportJobFolderPropertyToOverride = @import("asset_bundle_export_job_folder_property_to_override.zig").AssetBundleExportJobFolderPropertyToOverride;

/// Controls how a specific `Folder` resource is parameterized in the returned
/// CloudFormation template.
pub const AssetBundleExportJobFolderOverrideProperties = struct {
    /// The ARN of the specific `Folder` resource whose override properties are
    /// configured in this structure.
    arn: []const u8,

    /// A list of `Folder` resource properties to generate variables for in the
    /// returned CloudFormation template.
    properties: []const AssetBundleExportJobFolderPropertyToOverride,

    pub const json_field_names = .{
        .arn = "Arn",
        .properties = "Properties",
    };
};
