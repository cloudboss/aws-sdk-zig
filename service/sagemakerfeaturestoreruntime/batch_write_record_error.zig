const BatchWriteRecordEntry = @import("batch_write_record_entry.zig").BatchWriteRecordEntry;

/// The error that has occurred when attempting to write a record in a batch.
pub const BatchWriteRecordError = struct {
    /// The entry that failed to be written.
    entry: BatchWriteRecordEntry,

    /// The error code for the failed record write.
    error_code: []const u8,

    /// The error message for the failed record write.
    error_message: []const u8,

    pub const json_field_names = .{
        .entry = "Entry",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
