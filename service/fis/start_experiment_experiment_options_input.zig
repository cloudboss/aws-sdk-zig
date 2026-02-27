const ActionsMode = @import("actions_mode.zig").ActionsMode;

/// Specifies experiment options for running an experiment.
pub const StartExperimentExperimentOptionsInput = struct {
    /// Specifies the actions mode for experiment options.
    actions_mode: ?ActionsMode,

    pub const json_field_names = .{
        .actions_mode = "actionsMode",
    };
};
