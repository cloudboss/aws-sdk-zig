const ImportInstanceTaskDetails = @import("import_instance_task_details.zig").ImportInstanceTaskDetails;
const ImportVolumeTaskDetails = @import("import_volume_task_details.zig").ImportVolumeTaskDetails;
const ConversionTaskState = @import("conversion_task_state.zig").ConversionTaskState;
const Tag = @import("tag.zig").Tag;

/// Describes a conversion task.
pub const ConversionTask = struct {
    /// The ID of the conversion task.
    conversion_task_id: ?[]const u8,

    /// The time when the task expires. If the upload isn't complete before the
    /// expiration time, we automatically cancel
    /// the task.
    expiration_time: ?[]const u8,

    /// If the task is for importing an instance, this contains information about
    /// the import instance task.
    import_instance: ?ImportInstanceTaskDetails,

    /// If the task is for importing a volume, this contains information about the
    /// import volume task.
    import_volume: ?ImportVolumeTaskDetails,

    /// The state of the conversion task.
    state: ?ConversionTaskState,

    /// The status message related to the conversion task.
    status_message: ?[]const u8,

    /// Any tags assigned to the task.
    tags: ?[]const Tag,
};
