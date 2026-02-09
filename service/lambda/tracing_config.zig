const TracingMode = @import("tracing_mode.zig").TracingMode;

/// The function's
/// [X-Ray](https://docs.aws.amazon.com/lambda/latest/dg/services-xray.html)
/// tracing configuration. To sample and record incoming requests, set `Mode` to
/// `Active`.
pub const TracingConfig = struct {
    /// The tracing mode.
    mode: ?TracingMode,
};
