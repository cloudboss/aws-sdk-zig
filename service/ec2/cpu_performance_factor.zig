const PerformanceFactorReference = @import("performance_factor_reference.zig").PerformanceFactorReference;

/// The CPU performance to consider, using an instance family as the baseline
/// reference.
pub const CpuPerformanceFactor = struct {
    /// Specify an instance family to use as the baseline reference for CPU
    /// performance. All
    /// instance types that match your specified attributes will be compared against
    /// the CPU
    /// performance of the referenced instance family, regardless of CPU
    /// manufacturer or
    /// architecture differences.
    ///
    /// Currently, only one instance family can be specified in the list.
    references: ?[]const PerformanceFactorReference = null,
};
