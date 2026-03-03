const MatchCriteria = @import("match_criteria.zig").MatchCriteria;
const Range = @import("range.zig").Range;

/// An object to specify the predefined attribute condition.
pub const AttributeCondition = struct {
    /// The operator of the condition.
    comparison_operator: ?[]const u8 = null,

    /// An object to define `AgentsCriteria`.
    match_criteria: ?MatchCriteria = null,

    /// The name of predefined attribute.
    name: ?[]const u8 = null,

    /// The proficiency level of the condition.
    proficiency_level: ?f32 = null,

    /// An Object to define the minimum and maximum proficiency levels.
    range: ?Range = null,

    /// The value of predefined attribute.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .match_criteria = "MatchCriteria",
        .name = "Name",
        .proficiency_level = "ProficiencyLevel",
        .range = "Range",
        .value = "Value",
    };
};
