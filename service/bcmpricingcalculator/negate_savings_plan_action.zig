/// Represents an action to remove a Savings Plan from a bill scenario.
///
/// This is the ID of an existing Savings Plan in your account.
pub const NegateSavingsPlanAction = struct {
    /// The ID of the Savings Plan to remove.
    savings_plan_id: ?[]const u8,

    pub const json_field_names = .{
        .savings_plan_id = "savingsPlanId",
    };
};
