/// Contains details about the Lambda function containing the orchestration
/// logic carried out upon invoking the custom orchestration.
pub const OrchestrationExecutor = union(enum) {
    /// The Amazon Resource Name (ARN) of the Lambda function containing the
    /// business logic that is carried out upon invoking the action.
    lambda: ?[]const u8,

    pub const json_field_names = .{
        .lambda = "lambda",
    };
};
