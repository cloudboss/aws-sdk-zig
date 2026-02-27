/// Settings for logging access in a stage.
pub const AccessLogSettings = struct {
    /// The ARN of the CloudWatch Logs log group to receive access logs.
    destination_arn: ?[]const u8,

    /// A single line format of the access logs of data, as specified by selected
    /// $context variables. The format must include at least $context.requestId.
    format: ?[]const u8,

    pub const json_field_names = .{
        .destination_arn = "DestinationArn",
        .format = "Format",
    };
};
