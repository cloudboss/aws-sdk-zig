const TelemetryConfiguration = @import("telemetry_configuration.zig").TelemetryConfiguration;

/// Runtime configuration for a thing.
pub const RuntimeConfiguration = struct {
    /// Configuration for telemetry service.
    telemetry_configuration: ?TelemetryConfiguration = null,

    pub const json_field_names = .{
        .telemetry_configuration = "TelemetryConfiguration",
    };
};
