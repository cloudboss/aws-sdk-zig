const ExportToS3Task = @import("export_to_s_3_task.zig").ExportToS3Task;
const InstanceExportDetails = @import("instance_export_details.zig").InstanceExportDetails;
const ExportTaskState = @import("export_task_state.zig").ExportTaskState;
const Tag = @import("tag.zig").Tag;

/// Describes an export instance task.
pub const ExportTask = struct {
    /// A description of the resource being exported.
    description: ?[]const u8,

    /// The ID of the export task.
    export_task_id: ?[]const u8,

    /// Information about the export task.
    export_to_s_3_task: ?ExportToS3Task,

    /// Information about the instance to export.
    instance_export_details: ?InstanceExportDetails,

    /// The state of the export task.
    state: ?ExportTaskState,

    /// The status message related to the export task.
    status_message: ?[]const u8,

    /// The tags for the export task.
    tags: ?[]const Tag,
};
