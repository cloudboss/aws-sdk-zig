pub const EventType = enum {
    system,
    create_action,
    delete_action,
    update_action,
    execute_action,

    pub const json_field_names = .{
        .system = "System",
        .create_action = "CreateAction",
        .delete_action = "DeleteAction",
        .update_action = "UpdateAction",
        .execute_action = "ExecuteAction",
    };
};
