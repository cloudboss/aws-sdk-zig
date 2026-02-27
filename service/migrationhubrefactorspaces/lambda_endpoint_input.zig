/// The input for the Lambda endpoint type.
pub const LambdaEndpointInput = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function or alias.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
