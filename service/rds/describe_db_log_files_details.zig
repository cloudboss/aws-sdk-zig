/// This data type is used as a response element to `DescribeDBLogFiles`.
pub const DescribeDBLogFilesDetails = struct {
    /// A POSIX timestamp when the last log entry was written.
    last_written: ?i64,

    /// The name of the log file for the specified DB instance.
    log_file_name: ?[]const u8,

    /// The size, in bytes, of the log file for the specified DB instance.
    size: ?i64,
};
