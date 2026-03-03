const EvaluationMode = @import("evaluation_mode.zig").EvaluationMode;
const TimeWindow = @import("time_window.zig").TimeWindow;

/// Returns details of a resource evaluation based on the selected filter.
pub const ResourceEvaluationFilters = struct {
    /// Filters evaluations for a given infrastructure deployment. For example: CFN
    /// Stack.
    evaluation_context_identifier: ?[]const u8 = null,

    /// Filters all resource evaluations results based on an evaluation mode.
    ///
    /// Currently, `DECTECTIVE` is not supported as a valid value. Ignore other
    /// documentation stating otherwise.
    evaluation_mode: ?EvaluationMode = null,

    /// Returns a `TimeWindow` object.
    time_window: ?TimeWindow = null,

    pub const json_field_names = .{
        .evaluation_context_identifier = "EvaluationContextIdentifier",
        .evaluation_mode = "EvaluationMode",
        .time_window = "TimeWindow",
    };
};
