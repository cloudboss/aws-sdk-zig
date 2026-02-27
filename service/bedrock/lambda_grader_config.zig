/// Configuration for using an AWS Lambda function to grade model responses
/// during reinforcement fine-tuning training.
pub const LambdaGraderConfig = struct {
    /// ARN of the AWS Lambda function that will evaluate model responses and return
    /// reward scores for RFT training.
    lambda_arn: []const u8,

    pub const json_field_names = .{
        .lambda_arn = "lambdaArn",
    };
};
