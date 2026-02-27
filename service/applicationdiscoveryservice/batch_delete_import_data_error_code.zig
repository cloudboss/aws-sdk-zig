pub const BatchDeleteImportDataErrorCode = enum {
    not_found,
    internal_server_error,
    over_limit,

    pub const json_field_names = .{
        .not_found = "NOT_FOUND",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
        .over_limit = "OVER_LIMIT",
    };
};
