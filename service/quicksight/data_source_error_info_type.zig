pub const DataSourceErrorInfoType = enum {
    access_denied,
    copy_source_not_found,
    timeout,
    engine_version_not_supported,
    unknown_host,
    generic_sql_failure,
    conflict,
    unknown,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .copy_source_not_found = "COPY_SOURCE_NOT_FOUND",
        .timeout = "TIMEOUT",
        .engine_version_not_supported = "ENGINE_VERSION_NOT_SUPPORTED",
        .unknown_host = "UNKNOWN_HOST",
        .generic_sql_failure = "GENERIC_SQL_FAILURE",
        .conflict = "CONFLICT",
        .unknown = "UNKNOWN",
    };
};
