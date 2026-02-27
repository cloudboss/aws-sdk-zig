const RandomCutForestConfiguration = @import("random_cut_forest_configuration.zig").RandomCutForestConfiguration;

/// The configuration for the anomaly detection algorithm.
pub const AnomalyDetectorConfiguration = union(enum) {
    /// The Random Cut Forest algorithm configuration for anomaly detection.
    random_cut_forest: ?RandomCutForestConfiguration,

    pub const json_field_names = .{
        .random_cut_forest = "randomCutForest",
    };
};
