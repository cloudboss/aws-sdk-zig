const TelemetrySinkData = @import("telemetry_sink_data.zig").TelemetrySinkData;
const TelemetrySinkType = @import("telemetry_sink_type.zig").TelemetrySinkType;

/// Information about a telemetry sink `Config`.
pub const TelemetrySinkConfig = struct {
    /// Information about the telemetry sink specified by the `telemetrySinkType`.
    telemetry_sink_data: TelemetrySinkData,

    /// The type of telemetry sink.
    telemetry_sink_type: TelemetrySinkType,

    pub const json_field_names = .{
        .telemetry_sink_data = "telemetrySinkData",
        .telemetry_sink_type = "telemetrySinkType",
    };
};
