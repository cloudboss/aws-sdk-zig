pub const SbomValidationErrorCode = enum {
    incompatible_format,
    file_size_limit_exceeded,

    pub const json_field_names = .{
        .incompatible_format = "INCOMPATIBLE_FORMAT",
        .file_size_limit_exceeded = "FILE_SIZE_LIMIT_EXCEEDED",
    };
};
