pub const AgentParameterField = enum {
    /// Sampling interval in milliseconds used to sample profiles.
    sampling_interval_in_milliseconds,
    /// Reporting interval in milliseconds used to report profiles.
    reporting_interval_in_milliseconds,
    /// Minimum time in milliseconds between sending reports.
    minimum_time_for_reporting_in_milliseconds,
    /// Percentage of memory to be used by CodeGuru profiler. Minimum of 30MB is
    /// required for the agent.
    memory_usage_limit_percent,
    /// Maximum stack depth to be captured by the CodeGuru Profiler.
    max_stack_depth,

    pub const json_field_names = .{
        .sampling_interval_in_milliseconds = "SAMPLING_INTERVAL_IN_MILLISECONDS",
        .reporting_interval_in_milliseconds = "REPORTING_INTERVAL_IN_MILLISECONDS",
        .minimum_time_for_reporting_in_milliseconds = "MINIMUM_TIME_FOR_REPORTING_IN_MILLISECONDS",
        .memory_usage_limit_percent = "MEMORY_USAGE_LIMIT_PERCENT",
        .max_stack_depth = "MAX_STACK_DEPTH",
    };
};
