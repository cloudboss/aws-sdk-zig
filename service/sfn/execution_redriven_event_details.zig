/// Contains details about a redriven execution.
pub const ExecutionRedrivenEventDetails = struct {
    /// The number of times you've redriven an execution. If you have not yet
    /// redriven an execution, the `redriveCount` is 0. This count is not updated
    /// for redrives that failed to start or are pending to be redriven.
    redrive_count: ?i32,

    pub const json_field_names = .{
        .redrive_count = "redriveCount",
    };
};
