const ActionSet = @import("action_set.zig").ActionSet;
const Condition = @import("condition.zig").Condition;
const ResourceSet = @import("resource_set.zig").ResourceSet;

/// The permit definition specifying the authorized actions, resources, and
/// time-window conditions for a support operator.
pub const Permit = struct {
    /// The set of actions that the support operator is authorized to perform.
    actions: ActionSet,

    /// The time-window conditions that constrain when the permit is valid. Maximum
    /// of 2 conditions.
    conditions: ?[]const Condition = null,

    /// The set of resources that the support operator is authorized to act upon.
    resources: ResourceSet,

    pub const json_field_names = .{
        .actions = "actions",
        .conditions = "conditions",
        .resources = "resources",
    };
};
