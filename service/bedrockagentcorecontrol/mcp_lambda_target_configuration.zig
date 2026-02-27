const ToolSchema = @import("tool_schema.zig").ToolSchema;

/// The Lambda configuration for a Model Context Protocol target. This structure
/// defines how the gateway uses a Lambda function to communicate with the
/// target.
pub const McpLambdaTargetConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function. This function is
    /// invoked by the gateway to communicate with the target.
    lambda_arn: []const u8,

    /// The tool schema for the Lambda function. This schema defines the structure
    /// of the tools that the Lambda function provides.
    tool_schema: ToolSchema,

    pub const json_field_names = .{
        .lambda_arn = "lambdaArn",
        .tool_schema = "toolSchema",
    };
};
