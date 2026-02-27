/// Contains details about the specified export task.
pub const ExportTaskDetails = struct {
    /// The number of exported edges.
    num_edges_written: ?i64,

    /// The number of exported vertices.
    num_vertices_written: ?i64,

    /// The number of progress percentage of the export task.
    progress_percentage: i32,

    /// The start time of the export task.
    start_time: i64,

    /// The time elapsed, in seconds, since the start time of the export task.
    time_elapsed_seconds: i64,

    pub const json_field_names = .{
        .num_edges_written = "numEdgesWritten",
        .num_vertices_written = "numVerticesWritten",
        .progress_percentage = "progressPercentage",
        .start_time = "startTime",
        .time_elapsed_seconds = "timeElapsedSeconds",
    };
};
