const ParameterRanges = @import("parameter_ranges.zig").ParameterRanges;

/// Configuration information for a hyperparameter tuning job. You specify this
/// object in
/// the CreatePredictor request.
///
/// A *hyperparameter* is a parameter that governs the model training process.
/// You set
/// hyperparameters before training starts, unlike model parameters, which are
/// determined during
/// training. The values of the hyperparameters effect which values are chosen
/// for the model parameters.
///
/// In a *hyperparameter tuning job*, Amazon Forecast chooses the set of
/// hyperparameter
/// values that optimize a specified metric. Forecast accomplishes this by
/// running many training jobs
/// over a range of hyperparameter values. The optimum set of values depends on
/// the
/// algorithm, the training data, and the specified metric objective.
pub const HyperParameterTuningJobConfig = struct {
    /// Specifies the ranges of valid values for the hyperparameters.
    parameter_ranges: ?ParameterRanges,

    pub const json_field_names = .{
        .parameter_ranges = "ParameterRanges",
    };
};
