const ConfidenceLevel = @import("confidence_level.zig").ConfidenceLevel;

/// The configuration of an ML Detect Security Profile.
pub const MachineLearningDetectionConfig = struct {
    /// The sensitivity of anomalous behavior evaluation. Can be `Low`, `Medium`, or
    /// `High`.
    confidence_level: ConfidenceLevel,

    pub const json_field_names = .{
        .confidence_level = "confidenceLevel",
    };
};
