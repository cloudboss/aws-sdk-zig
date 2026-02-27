const EvaluationMode = @import("evaluation_mode.zig").EvaluationMode;

/// The configuration object for Config rule evaluation mode. The supported
/// valid values are Detective or Proactive.
pub const EvaluationModeConfiguration = struct {
    /// The mode of an evaluation. The valid values are Detective or Proactive.
    mode: ?EvaluationMode,

    pub const json_field_names = .{
        .mode = "Mode",
    };
};
