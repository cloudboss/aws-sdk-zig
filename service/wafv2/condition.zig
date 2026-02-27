const ActionCondition = @import("action_condition.zig").ActionCondition;
const LabelNameCondition = @import("label_name_condition.zig").LabelNameCondition;

/// A single match condition for a Filter.
pub const Condition = struct {
    /// A single action condition. This is the action setting that a log record must
    /// contain in order to meet the condition.
    action_condition: ?ActionCondition,

    /// A single label name condition. This is the fully qualified label name that a
    /// log record must contain in order to meet the condition.
    /// Fully qualified labels have a prefix, optional namespaces, and label name.
    /// The prefix identifies the rule group or web ACL context of the rule that
    /// added the label.
    label_name_condition: ?LabelNameCondition,

    pub const json_field_names = .{
        .action_condition = "ActionCondition",
        .label_name_condition = "LabelNameCondition",
    };
};
