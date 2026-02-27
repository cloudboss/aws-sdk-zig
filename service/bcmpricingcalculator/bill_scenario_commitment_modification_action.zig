const AddReservedInstanceAction = @import("add_reserved_instance_action.zig").AddReservedInstanceAction;
const AddSavingsPlanAction = @import("add_savings_plan_action.zig").AddSavingsPlanAction;
const NegateReservedInstanceAction = @import("negate_reserved_instance_action.zig").NegateReservedInstanceAction;
const NegateSavingsPlanAction = @import("negate_savings_plan_action.zig").NegateSavingsPlanAction;

/// Represents an action to modify commitments in a bill scenario.
pub const BillScenarioCommitmentModificationAction = union(enum) {
    /// Action to add a Reserved Instance to the scenario.
    add_reserved_instance_action: ?AddReservedInstanceAction,
    /// Action to add a Savings Plan to the scenario.
    add_savings_plan_action: ?AddSavingsPlanAction,
    /// Action to remove a Reserved Instance from the scenario.
    negate_reserved_instance_action: ?NegateReservedInstanceAction,
    /// Action to remove a Savings Plan from the scenario.
    negate_savings_plan_action: ?NegateSavingsPlanAction,

    pub const json_field_names = .{
        .add_reserved_instance_action = "addReservedInstanceAction",
        .add_savings_plan_action = "addSavingsPlanAction",
        .negate_reserved_instance_action = "negateReservedInstanceAction",
        .negate_savings_plan_action = "negateSavingsPlanAction",
    };
};
