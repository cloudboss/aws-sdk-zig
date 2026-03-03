const aws = @import("aws");

/// If hyperparameter optimization (HPO) was performed, contains the
/// hyperparameter values of
/// the best performing model.
pub const TunedHPOParams = struct {
    /// A list of the hyperparameter values of the best performing model.
    algorithm_hyper_parameters: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .algorithm_hyper_parameters = "algorithmHyperParameters",
    };
};
