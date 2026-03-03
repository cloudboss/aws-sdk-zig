/// A trigger failed to run.
pub const RepositoryTriggerExecutionFailure = struct {
    /// Message information about the trigger that did not run.
    failure_message: ?[]const u8 = null,

    /// The name of the trigger that did not run.
    trigger: ?[]const u8 = null,

    pub const json_field_names = .{
        .failure_message = "failureMessage",
        .trigger = "trigger",
    };
};
