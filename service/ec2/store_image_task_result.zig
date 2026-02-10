/// The information about the AMI store task, including the progress of the
/// task.
pub const StoreImageTaskResult = struct {
    /// The ID of the AMI that is being stored.
    ami_id: ?[]const u8,

    /// The name of the Amazon S3 bucket that contains the stored AMI object.
    bucket: ?[]const u8,

    /// The progress of the task as a percentage.
    progress_percentage: ?i32,

    /// The name of the stored AMI object in the bucket.
    s_3_object_key: ?[]const u8,

    /// If the tasks fails, the reason for the failure is returned. If the task
    /// succeeds,
    /// `null` is returned.
    store_task_failure_reason: ?[]const u8,

    /// The state of the store task (`InProgress`, `Completed`, or
    /// `Failed`).
    store_task_state: ?[]const u8,

    /// The time the task started.
    task_start_time: ?i64,
};
