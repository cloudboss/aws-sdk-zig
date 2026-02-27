const aws = @import("aws");

const RuleType = @import("rule_type.zig").RuleType;

/// Contains an Amazon Resource Name (ARN) and parameters that are associated
/// with the
/// rule.
pub const Rule = struct {
    /// The minimum and maximum parameters that are associated with the rule.
    parameters: ?[]const aws.map.StringMapEntry,

    /// The type of attribute validation rule.
    type: ?RuleType,

    pub const json_field_names = .{
        .parameters = "Parameters",
        .type = "Type",
    };
};
