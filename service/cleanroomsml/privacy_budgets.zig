const AccessBudget = @import("access_budget.zig").AccessBudget;

/// The privacy budget information that controls access to Clean Rooms ML input
/// channels.
pub const PrivacyBudgets = union(enum) {
    /// A list of access budgets that apply to resources associated with this Clean
    /// Rooms ML input channel.
    access_budgets: ?[]const AccessBudget,

    pub const json_field_names = .{
        .access_budgets = "accessBudgets",
    };
};
