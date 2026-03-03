const Tag = @import("tag.zig").Tag;
const ReplaceRootVolumeTaskState = @import("replace_root_volume_task_state.zig").ReplaceRootVolumeTaskState;

/// Information about a root volume replacement task.
pub const ReplaceRootVolumeTask = struct {
    /// The time the task completed.
    complete_time: ?[]const u8 = null,

    /// Indicates whether the original root volume is to be deleted after the root
    /// volume
    /// replacement task completes.
    delete_replaced_root_volume: ?bool = null,

    /// The ID of the AMI used to create the replacement root volume.
    image_id: ?[]const u8 = null,

    /// The ID of the instance for which the root volume replacement task was
    /// created.
    instance_id: ?[]const u8 = null,

    /// The ID of the root volume replacement task.
    replace_root_volume_task_id: ?[]const u8 = null,

    /// The ID of the snapshot used to create the replacement root volume.
    snapshot_id: ?[]const u8 = null,

    /// The time the task was started.
    start_time: ?[]const u8 = null,

    /// The tags assigned to the task.
    tags: ?[]const Tag = null,

    /// The state of the task. The task can be in one of the following states:
    ///
    /// * `pending` - the replacement volume is being created.
    ///
    /// * `in-progress` - the original volume is being detached and the
    /// replacement volume is being attached.
    ///
    /// * `succeeded` - the replacement volume has been successfully attached
    /// to the instance and the instance is available.
    ///
    /// * `failing` - the replacement task is in the process of failing.
    ///
    /// * `failed` - the replacement task has failed but the original root
    /// volume is still attached.
    ///
    /// * `failing-detached` - the replacement task is in the process of failing.
    /// The instance might have no root volume attached.
    ///
    /// * `failed-detached` - the replacement task has failed and the instance
    /// has no root volume attached.
    task_state: ?ReplaceRootVolumeTaskState = null,
};
