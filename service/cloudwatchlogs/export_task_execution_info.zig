/// Represents the status of an export task.
pub const ExportTaskExecutionInfo = struct {
    /// The completion time of the export task, expressed as the number of
    /// milliseconds after
    /// `Jan 1, 1970 00:00:00 UTC`.
    completion_time: ?i64,

    /// The creation time of the export task, expressed as the number of
    /// milliseconds after
    /// `Jan 1, 1970 00:00:00 UTC`.
    creation_time: ?i64,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .creation_time = "creationTime",
    };
};
