const Filter = @import("filter.zig").Filter;
const SamplingConfig = @import("sampling_config.zig").SamplingConfig;
const SessionConfig = @import("session_config.zig").SessionConfig;

/// The evaluation rule that defines sampling configuration, filtering criteria,
/// and session detection settings for online evaluation.
pub const Rule = struct {
    /// The list of filters that determine which agent traces should be included in
    /// the evaluation based on trace properties.
    filters: ?[]const Filter,

    /// The sampling configuration that determines what percentage of agent traces
    /// to evaluate.
    sampling_config: SamplingConfig,

    /// The session configuration that defines timeout settings for detecting when
    /// agent sessions are complete and ready for evaluation.
    session_config: ?SessionConfig,

    pub const json_field_names = .{
        .filters = "filters",
        .sampling_config = "samplingConfig",
        .session_config = "sessionConfig",
    };
};
