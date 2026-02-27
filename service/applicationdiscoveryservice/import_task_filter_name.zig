pub const ImportTaskFilterName = enum {
    import_task_id,
    status,
    name,
    file_classification,

    pub const json_field_names = .{
        .import_task_id = "IMPORT_TASK_ID",
        .status = "STATUS",
        .name = "NAME",
        .file_classification = "FILE_CLASSIFICATION",
    };
};
