/// A structure that contains the configuration settings for an AWS Lambda
/// function's data sink.
pub const LambdaFunctionSinkConfiguration = struct {
    /// The ARN of the sink.
    insights_target: ?[]const u8,

    pub const json_field_names = .{
        .insights_target = "InsightsTarget",
    };
};
