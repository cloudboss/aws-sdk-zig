/// Contains details about an import task.
pub const ImportTaskDetails = struct {
    /// The number of dictionary entries in the import task.
    dictionary_entry_count: i64,

    /// The number of errors encountered so far.
    error_count: i32,

    /// Details about the errors that have been encountered.
    error_details: ?[]const u8 = null,

    /// The percentage progress so far.
    progress_percentage: i32,

    /// Time at which the import task started.
    start_time: i64,

    /// The number of statements in the import task.
    statement_count: i64,

    /// Status of the import task.
    status: []const u8,

    /// Seconds elapsed since the import task started.
    time_elapsed_seconds: i64,

    pub const json_field_names = .{
        .dictionary_entry_count = "dictionaryEntryCount",
        .error_count = "errorCount",
        .error_details = "errorDetails",
        .progress_percentage = "progressPercentage",
        .start_time = "startTime",
        .statement_count = "statementCount",
        .status = "status",
        .time_elapsed_seconds = "timeElapsedSeconds",
    };
};
