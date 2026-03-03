/// Contains details about a lambda function that failed to start during an
/// execution.
pub const LambdaFunctionStartFailedEventDetails = struct {
    /// A more detailed explanation of the cause of the failure.
    cause: ?[]const u8 = null,

    /// The error code of the failure.
    @"error": ?[]const u8 = null,

    pub const json_field_names = .{
        .cause = "cause",
        .@"error" = "error",
    };
};
