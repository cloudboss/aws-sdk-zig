/// The number of directories that DataSync fails to list, prepare, transfer,
/// verify, and
/// delete during your task execution.
///
/// Applies only to [Enhanced mode
/// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
pub const TaskExecutionFoldersFailedDetail = struct {
    /// The number of directories that DataSync fails to delete during your task
    /// execution.
    delete: i64 = 0,

    /// The number of directories that DataSync fails to list during your task
    /// execution.
    list: i64 = 0,

    /// The number of directories that DataSync fails to prepare during your task
    /// execution.
    prepare: i64 = 0,

    /// The number of directories that DataSync fails to transfer during your task
    /// execution.
    transfer: i64 = 0,

    /// The number of directories that DataSync fails to verify during your task
    /// execution.
    verify: i64 = 0,

    pub const json_field_names = .{
        .delete = "Delete",
        .list = "List",
        .prepare = "Prepare",
        .transfer = "Transfer",
        .verify = "Verify",
    };
};
