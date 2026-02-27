pub const ToolName = enum {
    execute_code,
    execute_command,
    read_files,
    list_files,
    remove_files,
    write_files,
    start_command_execution,
    get_task,
    stop_task,

    pub const json_field_names = .{
        .execute_code = "EXECUTE_CODE",
        .execute_command = "EXECUTE_COMMAND",
        .read_files = "READ_FILES",
        .list_files = "LIST_FILES",
        .remove_files = "REMOVE_FILES",
        .write_files = "WRITE_FILES",
        .start_command_execution = "START_COMMAND_EXECUTION",
        .get_task = "GET_TASK",
        .stop_task = "STOP_TASK",
    };
};
