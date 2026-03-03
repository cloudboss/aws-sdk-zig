/// An object representing the protection status details for a task. You can set
/// the
/// protection status with the
/// [UpdateTaskProtection](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_UpdateTaskProtection.html) API and get the status of tasks with the [GetTaskProtection](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_GetTaskProtection.html) API.
pub const ProtectedTask = struct {
    /// The epoch time when protection for the task will expire.
    expiration_date: ?i64 = null,

    /// The protection status of the task. If scale-in protection is on for a task,
    /// the value
    /// is `true`. Otherwise, it is `false`.
    protection_enabled: bool = false,

    /// The task ARN.
    task_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .expiration_date = "expirationDate",
        .protection_enabled = "protectionEnabled",
        .task_arn = "taskArn",
    };
};
