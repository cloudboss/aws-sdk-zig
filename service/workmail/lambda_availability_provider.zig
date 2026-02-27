/// Describes a Lambda based availability provider.
pub const LambdaAvailabilityProvider = struct {
    /// The Amazon Resource Name (ARN) of the Lambda that acts as the availability
    /// provider.
    lambda_arn: []const u8,

    pub const json_field_names = .{
        .lambda_arn = "LambdaArn",
    };
};
