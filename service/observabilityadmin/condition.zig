const ActionCondition = @import("action_condition.zig").ActionCondition;
const LabelNameCondition = @import("label_name_condition.zig").LabelNameCondition;

/// A single condition that can match based on WAF rule action or label name.
pub const Condition = struct {
    /// Matches log records based on the WAF rule action taken (ALLOW, BLOCK, COUNT,
    /// etc.).
    action_condition: ?ActionCondition = null,

    /// Matches log records based on WAF rule labels applied to the request.
    label_name_condition: ?LabelNameCondition = null,

    pub const json_field_names = .{
        .action_condition = "ActionCondition",
        .label_name_condition = "LabelNameCondition",
    };
};
