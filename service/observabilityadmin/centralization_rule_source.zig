const SourceContextGraphConfiguration = @import("source_context_graph_configuration.zig").SourceContextGraphConfiguration;
const SourceLogsConfiguration = @import("source_logs_configuration.zig").SourceLogsConfiguration;
const SourceMetricsConfiguration = @import("source_metrics_configuration.zig").SourceMetricsConfiguration;

/// Configuration specifying the source of telemetry data to be centralized.
pub const CentralizationRuleSource = struct {
    /// The list of source regions from which telemetry data should be centralized.
    regions: []const []const u8,

    /// The organizational scope from which telemetry data should be centralized,
    /// specified using organization id, accounts or organizational unit ids.
    scope: ?[]const u8 = null,

    /// Configuration that enables centralization of the context graph for the
    /// selected sources. Including this configuration in a rule's source opts the
    /// rule into centralizing the context graph for the selected sources.
    source_context_graph_configuration: ?SourceContextGraphConfiguration = null,

    /// Log specific configuration for centralization source log groups.
    source_logs_configuration: ?SourceLogsConfiguration = null,

    /// Metric specific configuration for centralization source metrics.
    source_metrics_configuration: ?SourceMetricsConfiguration = null,

    pub const json_field_names = .{
        .regions = "Regions",
        .scope = "Scope",
        .source_context_graph_configuration = "SourceContextGraphConfiguration",
        .source_logs_configuration = "SourceLogsConfiguration",
        .source_metrics_configuration = "SourceMetricsConfiguration",
    };
};
