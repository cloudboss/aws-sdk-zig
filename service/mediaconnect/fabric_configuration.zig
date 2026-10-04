const FabricLatencyMode = @import("fabric_latency_mode.zig").FabricLatencyMode;

/// The fabric configuration settings for the router output.
pub const FabricConfiguration = struct {
    /// The recovery latency mode for the router fabric connection. Valid values
    /// include the following:
    ///
    /// * `BALANCED` (default) – Optimizes for stream quality.
    /// * `LOW_LATENCY` – Reduces latency at the potential cost of stream quality
    ///   under adverse network conditions.
    recovery_latency_mode: FabricLatencyMode,

    pub const json_field_names = .{
        .recovery_latency_mode = "RecoveryLatencyMode",
    };
};
