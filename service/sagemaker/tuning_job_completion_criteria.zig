const BestObjectiveNotImproving = @import("best_objective_not_improving.zig").BestObjectiveNotImproving;
const ConvergenceDetected = @import("convergence_detected.zig").ConvergenceDetected;

/// The job completion criteria.
pub const TuningJobCompletionCriteria = struct {
    /// A flag to stop your hyperparameter tuning job if model performance fails to
    /// improve as evaluated against an objective function.
    best_objective_not_improving: ?BestObjectiveNotImproving,

    /// A flag to top your hyperparameter tuning job if automatic model tuning (AMT)
    /// has detected that your model has converged as evaluated against your
    /// objective function.
    convergence_detected: ?ConvergenceDetected,

    /// The value of the objective metric.
    target_objective_metric_value: ?f32,

    pub const json_field_names = .{
        .best_objective_not_improving = "BestObjectiveNotImproving",
        .convergence_detected = "ConvergenceDetected",
        .target_objective_metric_value = "TargetObjectiveMetricValue",
    };
};
