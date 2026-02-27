pub const ProvisionedProductPlanStatus = enum {
    create_in_progress,
    create_success,
    create_failed,
    execute_in_progress,
    execute_success,
    execute_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_success = "CREATE_SUCCESS",
        .create_failed = "CREATE_FAILED",
        .execute_in_progress = "EXECUTE_IN_PROGRESS",
        .execute_success = "EXECUTE_SUCCESS",
        .execute_failed = "EXECUTE_FAILED",
    };
};
