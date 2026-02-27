const FileSource = @import("file_source.zig").FileSource;
const MetricsSource = @import("metrics_source.zig").MetricsSource;

/// Represents the drift check bias baselines that can be used when the model
/// monitor is set using the model package.
pub const DriftCheckBias = struct {
    /// The bias config file for a model.
    config_file: ?FileSource,

    /// The post-training constraints.
    post_training_constraints: ?MetricsSource,

    /// The pre-training constraints.
    pre_training_constraints: ?MetricsSource,

    pub const json_field_names = .{
        .config_file = "ConfigFile",
        .post_training_constraints = "PostTrainingConstraints",
        .pre_training_constraints = "PreTrainingConstraints",
    };
};
