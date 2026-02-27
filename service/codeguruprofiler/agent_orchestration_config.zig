/// Specifies whether profiling is enabled or disabled for a profiling group. It
/// is used by [
/// `ConfigureAgent`
/// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ConfigureAgent.html)
/// to enable or disable profiling for a profiling group.
pub const AgentOrchestrationConfig = struct {
    /// A `Boolean` that specifies whether the profiling agent collects profiling
    /// data or not. Set to `true`
    /// to enable profiling.
    profiling_enabled: bool,

    pub const json_field_names = .{
        .profiling_enabled = "profilingEnabled",
    };
};
