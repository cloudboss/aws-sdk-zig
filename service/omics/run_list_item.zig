const RunStatus = @import("run_status.zig").RunStatus;
const StorageType = @import("storage_type.zig").StorageType;

/// A workflow run.
pub const RunListItem = struct {
    /// The run's ARN.
    arn: ?[]const u8,

    /// When the run was created.
    creation_time: ?i64,

    /// The run's ID.
    id: ?[]const u8,

    /// The run's name.
    name: ?[]const u8,

    /// The run's priority.
    priority: ?i32,

    /// When the run started.
    start_time: ?i64,

    /// The run's status.
    status: ?RunStatus,

    /// When the run stopped.
    stop_time: ?i64,

    /// The run's storage capacity in gibibytes. For dynamic storage, after the run
    /// has completed, this value is the maximum amount of storage used during the
    /// run.
    storage_capacity: ?i32,

    /// The run's storage type.
    storage_type: ?StorageType,

    /// The run's workflow ID.
    workflow_id: ?[]const u8,

    /// The name of the workflow version.
    workflow_version_name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .id = "id",
        .name = "name",
        .priority = "priority",
        .start_time = "startTime",
        .status = "status",
        .stop_time = "stopTime",
        .storage_capacity = "storageCapacity",
        .storage_type = "storageType",
        .workflow_id = "workflowId",
        .workflow_version_name = "workflowVersionName",
    };
};
