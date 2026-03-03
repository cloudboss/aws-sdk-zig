const AttributeTypesSelector = @import("attribute_types_selector.zig").AttributeTypesSelector;
const ConflictResolution = @import("conflict_resolution.zig").ConflictResolution;
const ExportingConfig = @import("exporting_config.zig").ExportingConfig;
const MatchingRule = @import("matching_rule.zig").MatchingRule;
const RuleBasedMatchingStatus = @import("rule_based_matching_status.zig").RuleBasedMatchingStatus;

/// The response of the Rule-based matching request.
pub const RuleBasedMatchingResponse = struct {
    /// Configures information about the `AttributeTypesSelector` where the
    /// rule-based identity resolution uses to match profiles.
    attribute_types_selector: ?AttributeTypesSelector = null,

    conflict_resolution: ?ConflictResolution = null,

    /// The flag that enables the rule-based matching process of duplicate profiles.
    enabled: ?bool = null,

    exporting_config: ?ExportingConfig = null,

    /// Configures how the rule-based matching process should match profiles. You
    /// can have up to
    /// 15 `MatchingRule` in the `MatchingRules`.
    matching_rules: ?[]const MatchingRule = null,

    /// Indicates the maximum allowed rule level.
    max_allowed_rule_level_for_matching: ?i32 = null,

    /// [MatchingRule](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_MatchingRule.html)
    max_allowed_rule_level_for_merging: ?i32 = null,

    /// PENDING
    ///
    /// * The first status after configuration a rule-based matching rule. If it is
    ///   an
    /// existing domain, the rule-based Identity Resolution waits one hour before
    /// creating the matching
    /// rule. If it is a new domain, the system will skip the `PENDING`
    /// stage.
    ///
    /// IN_PROGRESS
    ///
    /// * The system is creating the rule-based matching rule. Under this status,
    ///   the system
    /// is evaluating the existing data and you can no longer change the Rule-based
    /// matching
    /// configuration.
    ///
    /// ACTIVE
    ///
    /// * The rule is ready to use. You can change the rule a day after the status
    ///   is in
    /// `ACTIVE`.
    status: ?RuleBasedMatchingStatus = null,

    pub const json_field_names = .{
        .attribute_types_selector = "AttributeTypesSelector",
        .conflict_resolution = "ConflictResolution",
        .enabled = "Enabled",
        .exporting_config = "ExportingConfig",
        .matching_rules = "MatchingRules",
        .max_allowed_rule_level_for_matching = "MaxAllowedRuleLevelForMatching",
        .max_allowed_rule_level_for_merging = "MaxAllowedRuleLevelForMerging",
        .status = "Status",
    };
};
