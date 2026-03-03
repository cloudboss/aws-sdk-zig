const DataValidationMetrics = @import("data_validation_metrics.zig").DataValidationMetrics;
const TrainingMetrics = @import("training_metrics.zig").TrainingMetrics;
const VariableImportanceMetrics = @import("variable_importance_metrics.zig").VariableImportanceMetrics;

/// The training result details.
pub const TrainingResult = struct {
    /// The validation metrics.
    data_validation_metrics: ?DataValidationMetrics = null,

    /// The training metric details.
    training_metrics: ?TrainingMetrics = null,

    /// The variable importance metrics.
    variable_importance_metrics: ?VariableImportanceMetrics = null,

    pub const json_field_names = .{
        .data_validation_metrics = "dataValidationMetrics",
        .training_metrics = "trainingMetrics",
        .variable_importance_metrics = "variableImportanceMetrics",
    };
};
