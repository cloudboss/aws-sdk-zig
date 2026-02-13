pub const CommandFilterKey = enum {
    invoked_after,
    invoked_before,
    status,
    execution_stage,
    document_name,

    pub const json_field_names = .{
        .invoked_after = "INVOKED_AFTER",
        .invoked_before = "INVOKED_BEFORE",
        .status = "STATUS",
        .execution_stage = "EXECUTION_STAGE",
        .document_name = "DOCUMENT_NAME",
    };
};
