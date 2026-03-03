/// The endpoint assigned to a SIP media application.
pub const SipMediaApplicationEndpoint = struct {
    /// Valid Amazon Resource Name (ARN) of the Lambda function, version, or alias.
    /// The function must be created in the same AWS Region as the SIP media
    /// application.
    lambda_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .lambda_arn = "LambdaArn",
    };
};
