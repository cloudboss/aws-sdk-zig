const CompleteOnConvergence = @import("complete_on_convergence.zig").CompleteOnConvergence;

/// A flag to indicating that automatic model tuning (AMT) has detected model
/// convergence, defined as a lack of significant improvement (1% or less)
/// against an objective metric.
pub const ConvergenceDetected = struct {
    /// A flag to stop a tuning job once AMT has detected that the job has
    /// converged.
    complete_on_convergence: ?CompleteOnConvergence = null,

    pub const json_field_names = .{
        .complete_on_convergence = "CompleteOnConvergence",
    };
};
