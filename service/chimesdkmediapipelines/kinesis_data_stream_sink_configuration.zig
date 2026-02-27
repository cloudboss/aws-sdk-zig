/// A structure that contains the configuration settings for a Kinesis Data
/// Stream sink.
pub const KinesisDataStreamSinkConfiguration = struct {
    /// The ARN of the sink.
    insights_target: ?[]const u8,

    pub const json_field_names = .{
        .insights_target = "InsightsTarget",
    };
};
