const ConfigurationSyncStatus = @import("configuration_sync_status.zig").ConfigurationSyncStatus;
const Telemetry = @import("telemetry.zig").Telemetry;

/// Configuration settings for running telemetry.
pub const TelemetryConfiguration = struct {
    /// Synchronization status of the device reported configuration with the desired
    /// configuration.
    configuration_sync_status: ?ConfigurationSyncStatus,

    /// Configure telemetry to be on or off.
    telemetry: Telemetry,

    pub const json_field_names = .{
        .configuration_sync_status = "ConfigurationSyncStatus",
        .telemetry = "Telemetry",
    };
};
