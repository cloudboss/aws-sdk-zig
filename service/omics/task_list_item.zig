const TaskStatus = @import("task_status.zig").TaskStatus;

/// A workflow run task.
pub const TaskListItem = struct {
    /// Set to true if Amazon Web Services HealthOmics found a matching entry in the
    /// run cache for this task.
    cache_hit: ?bool = null,

    /// The S3 URI of the cache location.
    cache_s3_uri: ?[]const u8 = null,

    /// The task's CPU count.
    cpus: ?i32 = null,

    /// When the task was created.
    creation_time: ?i64 = null,

    /// The number of Graphics Processing Units (GPU) specified for the task.
    gpus: ?i32 = null,

    /// The instance type for a task.
    instance_type: ?[]const u8 = null,

    /// The task's memory use in gigabyes.
    memory: ?i32 = null,

    /// The task's name.
    name: ?[]const u8 = null,

    /// When the task started.
    start_time: ?i64 = null,

    /// The task's status.
    status: ?TaskStatus = null,

    /// When the task stopped.
    stop_time: ?i64 = null,

    /// The task's ID.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cache_hit = "cacheHit",
        .cache_s3_uri = "cacheS3Uri",
        .cpus = "cpus",
        .creation_time = "creationTime",
        .gpus = "gpus",
        .instance_type = "instanceType",
        .memory = "memory",
        .name = "name",
        .start_time = "startTime",
        .status = "status",
        .stop_time = "stopTime",
        .task_id = "taskId",
    };
};
