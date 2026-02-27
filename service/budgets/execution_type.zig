pub const ExecutionType = enum {
    approve_budget_action,
    retry_budget_action,
    reverse_budget_action,
    reset_budget_action,

    pub const json_field_names = .{
        .approve_budget_action = "ApproveBudgetAction",
        .retry_budget_action = "RetryBudgetAction",
        .reverse_budget_action = "ReverseBudgetAction",
        .reset_budget_action = "ResetBudgetAction",
    };
};
