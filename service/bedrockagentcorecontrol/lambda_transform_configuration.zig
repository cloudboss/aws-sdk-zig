/// The Lambda configuration for custom transformations. This structure defines
/// the Lambda function that the gateway invokes to transform data.
pub const LambdaTransformConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function. This function is
    /// invoked by the gateway to transform data.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
