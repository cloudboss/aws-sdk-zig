const MetricSourceProvider = @import("metric_source_provider.zig").MetricSourceProvider;

/// The list of metric sources required to generate recommendations for
/// commercial software licenses.
pub const MetricSource = struct {
    /// The name of the metric source provider.
    provider: ?MetricSourceProvider = null,

    /// The ARN of the metric source provider.
    provider_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .provider = "provider",
        .provider_arn = "providerArn",
    };
};
