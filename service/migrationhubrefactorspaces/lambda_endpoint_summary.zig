/// The summary for the Lambda endpoint type.
pub const LambdaEndpointSummary = struct {
    /// The Amazon Resource Name (ARN) of the Lambda endpoint.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
