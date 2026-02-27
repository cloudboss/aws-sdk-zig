pub const SsmTargetAccount = enum {
    response_plan_owner_account,
    impacted_account,

    pub const json_field_names = .{
        .response_plan_owner_account = "RESPONSE_PLAN_OWNER_ACCOUNT",
        .impacted_account = "IMPACTED_ACCOUNT",
    };
};
