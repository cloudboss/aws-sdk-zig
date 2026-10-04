const AssetBundleExportJobTopicV2PropertyToOverride = @import("asset_bundle_export_job_topic_v2_property_to_override.zig").AssetBundleExportJobTopicV2PropertyToOverride;

/// Controls how a specific `Topic` resource is parameterized in the returned
/// CloudFormation template.
pub const AssetBundleExportJobTopicV2OverrideProperties = struct {
    /// The ARN of the specific `Topic` resource whose override properties are
    /// configured in this structure.
    arn: []const u8,

    /// A list of `Topic` resource properties to generate variables for in the
    /// returned CloudFormation template.
    properties: []const AssetBundleExportJobTopicV2PropertyToOverride,

    pub const json_field_names = .{
        .arn = "Arn",
        .properties = "Properties",
    };
};
