const Telemetry = @import("telemetry.zig").Telemetry;

/// Configuration settings for running telemetry.
pub const TelemetryConfigurationUpdate = struct {
    /// Configure telemetry to be on or off.
    telemetry: Telemetry,

    pub const json_field_names = .{
        .telemetry = "Telemetry",
    };
};
