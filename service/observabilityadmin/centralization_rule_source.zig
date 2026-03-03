const SourceLogsConfiguration = @import("source_logs_configuration.zig").SourceLogsConfiguration;

/// Configuration specifying the source of telemetry data to be centralized.
pub const CentralizationRuleSource = struct {
    /// The list of source regions from which telemetry data should be centralized.
    regions: []const []const u8,

    /// The organizational scope from which telemetry data should be centralized,
    /// specified using organization id, accounts or organizational unit ids.
    scope: ?[]const u8 = null,

    /// Log specific configuration for centralization source log groups.
    source_logs_configuration: ?SourceLogsConfiguration = null,

    pub const json_field_names = .{
        .regions = "Regions",
        .scope = "Scope",
        .source_logs_configuration = "SourceLogsConfiguration",
    };
};
