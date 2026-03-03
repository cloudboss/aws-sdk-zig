const HyperParameterRanges = @import("hyper_parameter_ranges.zig").HyperParameterRanges;
const HPOObjective = @import("hpo_objective.zig").HPOObjective;
const HPOResourceConfig = @import("hpo_resource_config.zig").HPOResourceConfig;

/// Describes the properties for hyperparameter optimization (HPO).
pub const HPOConfig = struct {
    /// The hyperparameters and their allowable ranges.
    algorithm_hyper_parameter_ranges: ?HyperParameterRanges = null,

    /// The metric to optimize during HPO.
    ///
    /// Amazon Personalize doesn't support configuring the `hpoObjective`
    /// at this time.
    hpo_objective: ?HPOObjective = null,

    /// Describes the resource configuration for HPO.
    hpo_resource_config: ?HPOResourceConfig = null,

    pub const json_field_names = .{
        .algorithm_hyper_parameter_ranges = "algorithmHyperParameterRanges",
        .hpo_objective = "hpoObjective",
        .hpo_resource_config = "hpoResourceConfig",
    };
};
