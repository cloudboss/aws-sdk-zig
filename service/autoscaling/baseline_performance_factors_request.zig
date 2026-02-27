const CpuPerformanceFactorRequest = @import("cpu_performance_factor_request.zig").CpuPerformanceFactorRequest;

/// The baseline performance to consider, using an instance family as a baseline
/// reference. The instance family establishes the lowest acceptable level of
/// performance. Auto Scaling uses
/// this baseline to guide instance type selection, but there is no guarantee
/// that the selected instance types will always exceed the baseline for every
/// application.
///
/// Currently, this parameter only supports CPU performance as a baseline
/// performance factor. For example, specifying `c6i` uses the CPU performance
/// of the `c6i`
/// family as the baseline reference.
pub const BaselinePerformanceFactorsRequest = struct {
    /// The CPU performance to consider, using an instance family as the baseline
    /// reference.
    cpu: ?CpuPerformanceFactorRequest,
};
