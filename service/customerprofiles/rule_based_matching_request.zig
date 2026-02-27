const AttributeTypesSelector = @import("attribute_types_selector.zig").AttributeTypesSelector;
const ConflictResolution = @import("conflict_resolution.zig").ConflictResolution;
const ExportingConfig = @import("exporting_config.zig").ExportingConfig;
const MatchingRule = @import("matching_rule.zig").MatchingRule;

/// The request to enable the rule-based matching.
pub const RuleBasedMatchingRequest = struct {
    /// Configures information about the `AttributeTypesSelector` where the
    /// rule-based identity resolution uses to match profiles.
    attribute_types_selector: ?AttributeTypesSelector,

    conflict_resolution: ?ConflictResolution,

    /// The flag that enables the rule-based matching process of duplicate profiles.
    enabled: bool,

    exporting_config: ?ExportingConfig,

    /// Configures how the rule-based matching process should match profiles. You
    /// can have up to
    /// 15 `MatchingRule` in the `MatchingRules`.
    matching_rules: ?[]const MatchingRule,

    /// Indicates the maximum allowed rule level.
    max_allowed_rule_level_for_matching: ?i32,

    /// [MatchingRule](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_MatchingRule.html)
    max_allowed_rule_level_for_merging: ?i32,

    pub const json_field_names = .{
        .attribute_types_selector = "AttributeTypesSelector",
        .conflict_resolution = "ConflictResolution",
        .enabled = "Enabled",
        .exporting_config = "ExportingConfig",
        .matching_rules = "MatchingRules",
        .max_allowed_rule_level_for_matching = "MaxAllowedRuleLevelForMatching",
        .max_allowed_rule_level_for_merging = "MaxAllowedRuleLevelForMerging",
    };
};
