pub const CodeGenerationStatus = enum {
    create_in_progress,
    create_complete,
    create_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_complete = "CREATE_COMPLETE",
        .create_failed = "CREATE_FAILED",
    };
};
