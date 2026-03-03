/// Contains information about settings for logging access for the stage.
pub const AwsApiGatewayAccessLogSettings = struct {
    /// The ARN of the CloudWatch Logs log group that receives the access logs.
    destination_arn: ?[]const u8 = null,

    /// A single-line format of the access logs of data, as specified by selected
    /// `$context` variables. The format must include at least
    /// `$context.requestId`.
    format: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_arn = "DestinationArn",
        .format = "Format",
    };
};
