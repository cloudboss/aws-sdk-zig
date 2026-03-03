const DestinationLogsConfiguration = @import("destination_logs_configuration.zig").DestinationLogsConfiguration;

/// Configuration specifying the primary destination for centralized telemetry
/// data.
pub const CentralizationRuleDestination = struct {
    /// The destination account (within the organization) to which the telemetry
    /// data should be centralized.
    account: ?[]const u8 = null,

    /// Log specific configuration for centralization destination log groups.
    destination_logs_configuration: ?DestinationLogsConfiguration = null,

    /// The primary destination region to which telemetry data should be
    /// centralized.
    region: []const u8,

    pub const json_field_names = .{
        .account = "Account",
        .destination_logs_configuration = "DestinationLogsConfiguration",
        .region = "Region",
    };
};
