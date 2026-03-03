const RuleAction = @import("rule_action.zig").RuleAction;
const RuleMatch = @import("rule_match.zig").RuleMatch;

/// Describes a successful rule update.
pub const RuleUpdateSuccess = struct {
    /// The action for the rule.
    action: ?RuleAction = null,

    /// The Amazon Resource Name (ARN) of the listener.
    arn: ?[]const u8 = null,

    /// The ID of the listener.
    id: ?[]const u8 = null,

    /// Indicates whether this is the default rule.
    is_default: ?bool = null,

    /// The rule match.
    match: ?RuleMatch = null,

    /// The name of the listener.
    name: ?[]const u8 = null,

    /// The rule priority.
    priority: ?i32 = null,

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
