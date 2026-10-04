const AwsConfigConnectorArnComparison = @import("aws_config_connector_arn_comparison.zig").AwsConfigConnectorArnComparison;

/// A filter that matches connectors by the ARN of the associated Amazon Web
/// Services Config connector.
pub const AwsConfigConnectorArnFilter = struct {
    /// The comparison operator for the Amazon Web Services Config connector ARN
    /// filter.
    comparison: AwsConfigConnectorArnComparison,

    /// The Amazon Web Services Config connector ARN value to filter by.
    value: []const u8,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
