/// The configuration settings for the SNS topic sink.
pub const SnsTopicSinkConfiguration = struct {
    /// The ARN of the SNS sink.
    insights_target: ?[]const u8 = null,

    pub const json_field_names = .{
        .insights_target = "InsightsTarget",
    };
};
