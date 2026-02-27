/// The interaction that stopped a pipeline execution.
pub const StopExecutionTrigger = struct {
    /// The user-specified reason the pipeline was stopped.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .reason = "reason",
    };
};
