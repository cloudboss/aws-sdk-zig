const AggregatedVariablesImportanceMetrics = @import("aggregated_variables_importance_metrics.zig").AggregatedVariablesImportanceMetrics;
const DataValidationMetrics = @import("data_validation_metrics.zig").DataValidationMetrics;
const TrainingMetricsV2 = @import("training_metrics_v2.zig").TrainingMetricsV2;
const VariableImportanceMetrics = @import("variable_importance_metrics.zig").VariableImportanceMetrics;

/// The training result details.
pub const TrainingResultV2 = struct {
    /// The variable importance metrics of the aggregated variables.
    ///
    /// Account Takeover Insights (ATI) model uses event variables from the login
    /// data you
    /// provide to continuously calculate a set of variables (aggregated variables)
    /// based on historical events. For example, your ATI model might calculate the
    /// number of times an user has logged in using the same IP address.
    /// In this case, event variables used to derive the aggregated variables are
    /// `IP address` and `user`.
    aggregated_variables_importance_metrics: ?AggregatedVariablesImportanceMetrics,

    data_validation_metrics: ?DataValidationMetrics,

    /// The training metric details.
    training_metrics_v2: ?TrainingMetricsV2,

    variable_importance_metrics: ?VariableImportanceMetrics,

    pub const json_field_names = .{
        .aggregated_variables_importance_metrics = "aggregatedVariablesImportanceMetrics",
        .data_validation_metrics = "dataValidationMetrics",
        .training_metrics_v2 = "trainingMetricsV2",
        .variable_importance_metrics = "variableImportanceMetrics",
    };
};
