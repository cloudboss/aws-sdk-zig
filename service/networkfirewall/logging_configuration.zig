const LogDestinationConfig = @import("log_destination_config.zig").LogDestinationConfig;

/// Defines how Network Firewall performs logging for a Firewall.
pub const LoggingConfiguration = struct {
    /// Defines the logging destinations for the logs for a firewall. Network
    /// Firewall generates
    /// logs for stateful rule groups.
    log_destination_configs: []const LogDestinationConfig,

    pub const json_field_names = .{
        .log_destination_configs = "LogDestinationConfigs",
    };
};
