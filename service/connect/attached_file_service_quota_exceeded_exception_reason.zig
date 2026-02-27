pub const AttachedFileServiceQuotaExceededExceptionReason = enum {
    total_file_size_exceeded,
    total_file_count_exceeded,

    pub const json_field_names = .{
        .total_file_size_exceeded = "TOTAL_FILE_SIZE_EXCEEDED",
        .total_file_count_exceeded = "TOTAL_FILE_COUNT_EXCEEDED",
    };
};
