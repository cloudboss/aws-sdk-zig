const RuleAction = @import("rule_action.zig").RuleAction;
const RuleMatch = @import("rule_match.zig").RuleMatch;

/// Describes a successful rule update.
pub const RuleUpdateSuccess = struct {
    /// The action for the rule.
    action: ?RuleAction,

    /// The Amazon Resource Name (ARN) of the listener.
    arn: ?[]const u8,

    /// The ID of the listener.
    id: ?[]const u8,

    /// Indicates whether this is the default rule.
    is_default: ?bool,

    /// The rule match.
    match: ?RuleMatch,

    /// The name of the listener.
    name: ?[]const u8,

    /// The rule priority.
    priority: ?i32,

    pub const json_field_names = .{
        .action = "action",
        .arn = "arn",
        .id = "id",
        .is_default = "isDefault",
        .match = "match",
        .name = "name",
        .priority = "priority",
    };
};
