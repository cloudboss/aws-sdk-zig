/// Configuration for the Amazon Data Firehose stream destination of user
/// activity log export with
/// threat protection.
pub const FirehoseConfigurationType = struct {
    /// The ARN of an Amazon Data Firehose stream that's the destination for threat
    /// protection log
    /// export.
    stream_arn: ?[]const u8,

    pub const json_field_names = .{
        .stream_arn = "StreamArn",
    };
};
