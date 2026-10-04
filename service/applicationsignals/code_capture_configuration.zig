const CaptureLimitsConfig = @import("capture_limits_config.zig").CaptureLimitsConfig;

/// Defines what data to capture for code-level instrumentation, including
/// arguments, return values, stack traces, local variables, and safety limits.
pub const CodeCaptureConfiguration = struct {
    /// The function arguments to capture. Omit to capture defaults, use an empty
    /// list to capture none, use `["*"]` to capture all arguments, or specify
    /// argument names to capture selectively (up to 10 entries).
    capture_arguments: ?[]const []const u8 = null,

    /// Safety limits that bound what is captured, including hit counts, string
    /// length, collection depth, and stack trace size.
    capture_limits: CaptureLimitsConfig,

    /// The local variables to capture by name. Omit or pass an empty list to
    /// capture none. You can specify up to 20 names.
    capture_locals: ?[]const []const u8 = null,

    /// Whether to capture the return value. Defaults to false.
    capture_return: ?bool = null,

    /// Whether to capture a stack trace when the instrumentation point is hit.
    /// Defaults to true.
    capture_stack_trace: ?bool = null,

    pub const json_field_names = .{
        .capture_arguments = "CaptureArguments",
        .capture_limits = "CaptureLimits",
        .capture_locals = "CaptureLocals",
        .capture_return = "CaptureReturn",
        .capture_stack_trace = "CaptureStackTrace",
    };
};
