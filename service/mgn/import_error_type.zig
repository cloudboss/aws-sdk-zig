pub const ImportErrorType = enum {
    validation_error,
    processing_error,

    pub const json_field_names = .{
        .validation_error = "VALIDATION_ERROR",
        .processing_error = "PROCESSING_ERROR",
    };
};
