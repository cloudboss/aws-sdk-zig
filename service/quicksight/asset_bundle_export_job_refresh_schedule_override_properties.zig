const AssetBundleExportJobRefreshSchedulePropertyToOverride = @import("asset_bundle_export_job_refresh_schedule_property_to_override.zig").AssetBundleExportJobRefreshSchedulePropertyToOverride;

/// Controls how a specific `RefreshSchedule` resource is parameterized in the
/// returned CloudFormation template.
pub const AssetBundleExportJobRefreshScheduleOverrideProperties = struct {
    /// The ARN of the specific `RefreshSchedule` resource whose override properties
    /// are configured in this structure.
    arn: []const u8,

    /// A list of `RefreshSchedule` resource properties to generate variables for in
    /// the returned CloudFormation template.
    properties: []const AssetBundleExportJobRefreshSchedulePropertyToOverride,

    pub const json_field_names = .{
        .arn = "Arn",
        .properties = "Properties",
    };
};
