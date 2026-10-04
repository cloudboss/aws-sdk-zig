const CodeCaptureConfiguration = @import("code_capture_configuration.zig").CodeCaptureConfiguration;

/// A union that defines what data to capture when the instrumentation point is
/// hit. Specify `CodeCapture` for code-level capture settings.
pub const CaptureConfiguration = union(enum) {
    /// Capture settings for code-level instrumentation, including arguments, return
    /// values, stack traces, local variables, and safety limits.
    code_capture: ?CodeCaptureConfiguration,

    pub const json_field_names = .{
        .code_capture = "CodeCapture",
    };
};
