/// Contains details about the start of an activity during an execution.
pub const ActivityStartedEventDetails = struct {
    /// The name of the worker that the task is assigned to. These names are
    /// provided by the
    /// workers when calling GetActivityTask.
    worker_name: ?[]const u8,

    pub const json_field_names = .{
        .worker_name = "workerName",
    };
};
