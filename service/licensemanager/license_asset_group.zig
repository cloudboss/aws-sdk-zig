const LicenseAssetGroupConfiguration = @import("license_asset_group_configuration.zig").LicenseAssetGroupConfiguration;
const LicenseAssetGroupProperty = @import("license_asset_group_property.zig").LicenseAssetGroupProperty;
const LicenseAssetGroupStatus = @import("license_asset_group_status.zig").LicenseAssetGroupStatus;

/// License asset group.
pub const LicenseAssetGroup = struct {
    /// ARNs of associated license asset rulesets.
    associated_license_asset_ruleset_ar_ns: []const []const u8,

    /// License asset group description.
    description: ?[]const u8,

    /// Latest resource discovery time.
    latest_resource_discovery_time: ?i64,

    /// Latest usage analysis time.
    latest_usage_analysis_time: ?i64,

    /// Amazon Resource Name (ARN) of the license asset group.
    license_asset_group_arn: []const u8,

    /// License asset group configurations.
    license_asset_group_configurations: ?[]const LicenseAssetGroupConfiguration,

    /// License asset group name.
    name: []const u8,

    /// License asset group properties.
    properties: ?[]const LicenseAssetGroupProperty,

    /// License asset group status.
    status: LicenseAssetGroupStatus,

    /// License asset group status message.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .associated_license_asset_ruleset_ar_ns = "AssociatedLicenseAssetRulesetARNs",
        .description = "Description",
        .latest_resource_discovery_time = "LatestResourceDiscoveryTime",
        .latest_usage_analysis_time = "LatestUsageAnalysisTime",
        .license_asset_group_arn = "LicenseAssetGroupArn",
        .license_asset_group_configurations = "LicenseAssetGroupConfigurations",
        .name = "Name",
        .properties = "Properties",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
