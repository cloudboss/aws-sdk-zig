/// The configuration settings for the SQS sink.
pub const SqsQueueSinkConfiguration = struct {
    /// The ARN of the SQS sink.
    insights_target: ?[]const u8,

    pub const json_field_names = .{
        .insights_target = "InsightsTarget",
    };
};
