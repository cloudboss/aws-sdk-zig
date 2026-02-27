const CollectorHealth = @import("collector_health.zig").CollectorHealth;
const ConfigurationSummary = @import("configuration_summary.zig").ConfigurationSummary;

/// Process data collector that runs in the environment that you specify.
pub const Collector = struct {
    /// Indicates the health of a collector.
    collector_health: ?CollectorHealth,

    /// The ID of the collector.
    collector_id: ?[]const u8,

    /// Current version of the collector that is running in the environment that you
    /// specify.
    collector_version: ?[]const u8,

    /// Summary of the collector configuration.
    configuration_summary: ?ConfigurationSummary,

    /// Hostname of the server that is hosting the collector.
    host_name: ?[]const u8,

    /// IP address of the server that is hosting the collector.
    ip_address: ?[]const u8,

    /// Time when the collector last pinged the service.
    last_activity_time_stamp: ?[]const u8,

    /// Time when the collector registered with the service.
    registered_time_stamp: ?[]const u8,

    pub const json_field_names = .{
        .collector_health = "collectorHealth",
        .collector_id = "collectorId",
        .collector_version = "collectorVersion",
        .configuration_summary = "configurationSummary",
        .host_name = "hostName",
        .ip_address = "ipAddress",
        .last_activity_time_stamp = "lastActivityTimeStamp",
        .registered_time_stamp = "registeredTimeStamp",
    };
};
