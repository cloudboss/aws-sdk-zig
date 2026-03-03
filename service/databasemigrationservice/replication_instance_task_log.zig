/// Contains metadata for a replication instance task log.
pub const ReplicationInstanceTaskLog = struct {
    /// The size, in bytes, of the replication task log.
    replication_instance_task_log_size: i64 = 0,

    /// The Amazon Resource Name (ARN) of the replication task.
    replication_task_arn: ?[]const u8 = null,

    /// The name of the replication task.
    replication_task_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .replication_instance_task_log_size = "ReplicationInstanceTaskLogSize",
        .replication_task_arn = "ReplicationTaskArn",
        .replication_task_name = "ReplicationTaskName",
    };
};
