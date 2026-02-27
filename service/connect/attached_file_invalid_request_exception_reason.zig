pub const AttachedFileInvalidRequestExceptionReason = enum {
    invalid_file_size,
    invalid_file_type,
    invalid_file_name,

    pub const json_field_names = .{
        .invalid_file_size = "INVALID_FILE_SIZE",
        .invalid_file_type = "INVALID_FILE_TYPE",
        .invalid_file_name = "INVALID_FILE_NAME",
    };
};
