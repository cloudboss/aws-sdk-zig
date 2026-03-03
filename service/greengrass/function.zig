const FunctionConfiguration = @import("function_configuration.zig").FunctionConfiguration;

/// Information about a Lambda function.
pub const Function = struct {
    /// The ARN of the Lambda function.
    function_arn: ?[]const u8 = null,

    /// The configuration of the Lambda function.
    function_configuration: ?FunctionConfiguration = null,

    /// A descriptive or arbitrary ID for the function. This value must be unique
    /// within the function definition version. Max length is 128 characters with
    /// pattern ''[a-zA-Z0-9:_-]+''.
    id: []const u8,

    pub const json_field_names = .{
        .function_arn = "FunctionArn",
        .function_configuration = "FunctionConfiguration",
        .id = "Id",
    };
};
