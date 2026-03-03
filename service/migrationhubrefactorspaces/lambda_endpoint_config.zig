/// The configuration for the Lambda endpoint type.
pub const LambdaEndpointConfig = struct {
    /// The Amazon Resource Name (ARN) of the Lambda endpoint.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
