pub const ErrorCode = enum {
    no_usage_found,
    internal_failure,
    invalid_savings_plans_to_add,
    invalid_savings_plans_to_exclude,
    invalid_account_id,

    pub const json_field_names = .{
        .no_usage_found = "NO_USAGE_FOUND",
        .internal_failure = "INTERNAL_FAILURE",
        .invalid_savings_plans_to_add = "INVALID_SAVINGS_PLANS_TO_ADD",
        .invalid_savings_plans_to_exclude = "INVALID_SAVINGS_PLANS_TO_EXCLUDE",
        .invalid_account_id = "INVALID_ACCOUNT_ID",
    };
};
