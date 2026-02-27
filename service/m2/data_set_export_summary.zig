/// Represents a summary of data set exports.
pub const DataSetExportSummary = struct {
    /// The number of data set exports that have failed.
    failed: i32 = 0,

    /// The number of data set exports that are in progress.
    in_progress: i32 = 0,

    /// The number of data set exports that are pending.
    pending: i32 = 0,

    /// The number of data set exports that have succeeded.
    succeeded: i32 = 0,

    /// The total number of data set exports.
    total: i32 = 0,

    pub const json_field_names = .{
        .failed = "failed",
        .in_progress = "inProgress",
        .pending = "pending",
        .succeeded = "succeeded",
        .total = "total",
    };
};
