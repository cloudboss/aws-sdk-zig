const TracingMode = @import("tracing_mode.zig").TracingMode;

/// The function's X-Ray tracing configuration.
pub const TracingConfigResponse = struct {
    /// The tracing mode.
    mode: ?TracingMode,
};
