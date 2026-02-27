const aws = @import("aws");

const PipelineObject = @import("pipeline_object.zig").PipelineObject;

/// Contains information about a pipeline task that is assigned to a task
/// runner.
pub const TaskObject = struct {
    /// The ID of the pipeline task attempt object. AWS Data Pipeline uses this
    /// value to track how many times a task is attempted.
    attempt_id: ?[]const u8,

    /// Connection information for the location where the task runner will publish
    /// the output of the task.
    objects: ?[]const aws.map.MapEntry(PipelineObject),

    /// The ID of the pipeline that provided the task.
    pipeline_id: ?[]const u8,

    /// An internal identifier for the task. This ID is passed to the SetTaskStatus
    /// and ReportTaskProgress actions.
    task_id: ?[]const u8,

    pub const json_field_names = .{
        .attempt_id = "attemptId",
        .objects = "objects",
        .pipeline_id = "pipelineId",
        .task_id = "taskId",
    };
};
