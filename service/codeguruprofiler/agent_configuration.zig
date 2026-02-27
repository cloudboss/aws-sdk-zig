const aws = @import("aws");

/// The response of [
/// `ConfigureAgent`
/// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ConfigureAgent.html) that
/// specifies if an agent profiles or not and for how long to return profiling
/// data.
pub const AgentConfiguration = struct {
    /// Parameters used by the profiler. The valid parameters are:
    ///
    /// * `MaxStackDepth` - The maximum depth of the stacks in the code that is
    ///   represented in
    /// the profile. For example, if CodeGuru Profiler finds a method `A`,
    /// which calls method `B`, which calls method `C`, which
    /// calls method `D`, then the depth is 4. If the `maxDepth` is
    /// set to 2, then the profiler evaluates `A` and `B`.
    ///
    /// * `MemoryUsageLimitPercent` - The percentage of memory that is used by the
    /// profiler.
    ///
    /// * `MinimumTimeForReportingInMilliseconds` - The minimum time in milliseconds
    ///   between
    /// sending reports.
    ///
    /// * `ReportingIntervalInMilliseconds` - The reporting interval in milliseconds
    ///   used
    /// to report profiles.
    ///
    /// * `SamplingIntervalInMilliseconds` - The sampling interval in milliseconds
    ///   that is used to
    /// profile samples.
    agent_parameters: ?[]const aws.map.StringMapEntry,

    /// How long a profiling agent should send profiling data using
    /// [
    /// `ConfigureAgent`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ConfigureAgent.html).
    /// For example, if this is set to 300, the profiling agent calls [
    /// `ConfigureAgent`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ConfigureAgent.html)
    /// every 5 minutes to submit the profiled data collected during that period.
    period_in_seconds: i32,

    /// A `Boolean` that specifies whether the profiling agent collects profiling
    /// data or not. Set to `true`
    /// to enable profiling.
    should_profile: bool,

    pub const json_field_names = .{
        .agent_parameters = "agentParameters",
        .period_in_seconds = "periodInSeconds",
        .should_profile = "shouldProfile",
    };
};
