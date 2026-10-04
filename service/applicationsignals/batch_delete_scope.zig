const InstrumentationType = @import("instrumentation_type.zig").InstrumentationType;

/// Scope parameters for bulk delete by scope.
pub const BatchDeleteScope = struct {
    /// Environment identifier for the instrumentation configurations.
    environment: []const u8,

    /// Instrumentation type: BREAKPOINT or PROBE.
    instrumentation_type: InstrumentationType,

    /// Service name for the instrumentation configurations.
    service: []const u8,

    pub const json_field_names = .{
        .environment = "Environment",
        .instrumentation_type = "InstrumentationType",
        .service = "Service",
    };
};
