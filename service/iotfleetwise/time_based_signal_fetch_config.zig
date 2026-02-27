/// Used to configure a frequency-based vehicle signal fetch.
pub const TimeBasedSignalFetchConfig = struct {
    /// The frequency with which the signal fetch will be executed.
    execution_frequency_ms: i64,

    pub const json_field_names = .{
        .execution_frequency_ms = "executionFrequencyMs",
    };
};
