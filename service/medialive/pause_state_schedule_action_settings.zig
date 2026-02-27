const PipelinePauseStateSettings = @import("pipeline_pause_state_settings.zig").PipelinePauseStateSettings;

/// Settings for the action to set pause state of a channel.
pub const PauseStateScheduleActionSettings = struct {
    pipelines: ?[]const PipelinePauseStateSettings,

    pub const json_field_names = .{
        .pipelines = "Pipelines",
    };
};
