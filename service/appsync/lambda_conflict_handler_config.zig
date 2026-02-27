/// The `LambdaConflictHandlerConfig` object when configuring `LAMBDA`
/// as the Conflict Handler.
pub const LambdaConflictHandlerConfig = struct {
    /// The Amazon Resource Name (ARN) for the Lambda function to use as the
    /// Conflict Handler.
    lambda_conflict_handler_arn: ?[]const u8,

    pub const json_field_names = .{
        .lambda_conflict_handler_arn = "lambdaConflictHandlerArn",
    };
};
