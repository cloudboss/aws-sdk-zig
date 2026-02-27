pub const DataRepositoryTaskFilterName = enum {
    file_system_id,
    task_lifecycle,
    data_repo_association_id,
    file_cache_id,

    pub const json_field_names = .{
        .file_system_id = "FILE_SYSTEM_ID",
        .task_lifecycle = "TASK_LIFECYCLE",
        .data_repo_association_id = "DATA_REPO_ASSOCIATION_ID",
        .file_cache_id = "FILE_CACHE_ID",
    };
};
