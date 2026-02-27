/// Information about a budget.
pub const BudgetDetail = struct {
    /// Name of the associated budget.
    budget_name: ?[]const u8,

    pub const json_field_names = .{
        .budget_name = "BudgetName",
    };
};
