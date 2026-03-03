const ResultFrame = @import("result_frame.zig").ResultFrame;

/// The result of a SQL statement.
///
/// This data structure is only used with the deprecated `ExecuteSql` operation.
/// Use the `BatchExecuteStatement` or `ExecuteStatement` operation instead.
pub const SqlStatementResult = struct {
    /// The number of records updated by a SQL statement.
    number_of_records_updated: i64 = 0,

    /// The result set of the SQL statement.
    result_frame: ?ResultFrame = null,

    pub const json_field_names = .{
        .number_of_records_updated = "numberOfRecordsUpdated",
        .result_frame = "resultFrame",
    };
};
