const InferenceExecutionMode = @import("inference_execution_mode.zig").InferenceExecutionMode;

/// Specifies details about how containers in a multi-container endpoint are
/// run.
pub const InferenceExecutionConfig = struct {
    /// How containers in a multi-container are run. The following values are valid.
    ///
    /// * `SERIAL` - Containers run as a serial pipeline.
    /// * `DIRECT` - Only the individual container that you specify is run.
    mode: InferenceExecutionMode,

    pub const json_field_names = .{
        .mode = "Mode",
    };
};
