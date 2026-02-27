const LicenseAssetRule = @import("license_asset_rule.zig").LicenseAssetRule;

/// License asset ruleset.
pub const LicenseAssetRuleset = struct {
    /// License asset ruleset description.
    description: ?[]const u8,

    /// Amazon Resource Name (ARN) of the license asset ruleset.
    license_asset_ruleset_arn: []const u8,

    /// License asset ruleset name.
    name: []const u8,

    /// License asset rules.
    rules: []const LicenseAssetRule,

    pub const json_field_names = .{
        .description = "Description",
        .license_asset_ruleset_arn = "LicenseAssetRulesetArn",
        .name = "Name",
        .rules = "Rules",
    };
};
