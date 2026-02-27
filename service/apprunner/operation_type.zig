pub const OperationType = enum {
    start_deployment,
    create_service,
    pause_service,
    resume_service,
    delete_service,
    update_service,

    pub const json_field_names = .{
        .start_deployment = "START_DEPLOYMENT",
        .create_service = "CREATE_SERVICE",
        .pause_service = "PAUSE_SERVICE",
        .resume_service = "RESUME_SERVICE",
        .delete_service = "DELETE_SERVICE",
        .update_service = "UPDATE_SERVICE",
    };
};
