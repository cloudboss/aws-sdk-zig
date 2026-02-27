/// The name for a filter.
pub const FilterName = enum {
    file_system_id,
    backup_type,
    file_system_type,
    volume_id,
    data_repository_type,
    file_cache_id,
    file_cache_type,

    pub const json_field_names = .{
        .file_system_id = "FILE_SYSTEM_ID",
        .backup_type = "BACKUP_TYPE",
        .file_system_type = "FILE_SYSTEM_TYPE",
        .volume_id = "VOLUME_ID",
        .data_repository_type = "DATA_REPOSITORY_TYPE",
        .file_cache_id = "FILE_CACHE_ID",
        .file_cache_type = "FILE_CACHE_TYPE",
    };
};
