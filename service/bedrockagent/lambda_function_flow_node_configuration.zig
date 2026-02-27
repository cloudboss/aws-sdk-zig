/// Contains configurations for a Lambda function node in the flow. You specify
/// the Lambda function to invoke and the inputs into the function. The output
/// is the response that is defined in the Lambda function. For more
/// information, see [Node types in a
/// flow](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-nodes.html)
/// in the Amazon Bedrock User Guide.
pub const LambdaFunctionFlowNodeConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function to invoke.
    lambda_arn: []const u8 = "",

    pub const json_field_names = .{
        .lambda_arn = "lambdaArn",
    };
};
