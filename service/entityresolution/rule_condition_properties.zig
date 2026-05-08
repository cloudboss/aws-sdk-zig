const MatchingConfig = @import("matching_config.zig").MatchingConfig;
const RuleCondition = @import("rule_condition.zig").RuleCondition;

/// The properties of a rule condition that provides the ability to use more
/// complex syntax.
pub const RuleConditionProperties = struct {
    /// An object that contains configuration settings for the matching process.
    matching_config: ?MatchingConfig = null,

    /// A list of rule objects, each of which have fields `ruleName` and
    /// `condition`.
    rules: []const RuleCondition,

    pub const json_field_names = .{
        .matching_config = "matchingConfig",
        .rules = "rules",
    };
};
