/// The number of files or objects that DataSync fails to prepare, transfer,
/// verify, and
/// delete during your task execution.
///
/// Applies only to [Enhanced mode
/// tasks](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html).
pub const TaskExecutionFilesFailedDetail = struct {
    /// The number of files or objects that DataSync fails to delete during your
    /// task
    /// execution.
    delete: i64 = 0,

    /// The number of files or objects that DataSync fails to prepare during your
    /// task
    /// execution.
    prepare: i64 = 0,

    /// The number of files or objects that DataSync fails to transfer during your
    /// task
    /// execution.
    transfer: i64 = 0,

    /// The number of files or objects that DataSync fails to verify during your
    /// task
    /// execution.
    verify: i64 = 0,

    pub const json_field_names = .{
        .delete = "Delete",
        .prepare = "Prepare",
        .transfer = "Transfer",
        .verify = "Verify",
    };
};
