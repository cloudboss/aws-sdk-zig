const ComputationModelAnomalyDetectionConfiguration = @import("computation_model_anomaly_detection_configuration.zig").ComputationModelAnomalyDetectionConfiguration;

/// The configuration for the computation model.
pub const ComputationModelConfiguration = struct {
    /// The configuration for the anomaly detection type of computation model.
    anomaly_detection: ?ComputationModelAnomalyDetectionConfiguration,

    pub const json_field_names = .{
        .anomaly_detection = "anomalyDetection",
    };
};
