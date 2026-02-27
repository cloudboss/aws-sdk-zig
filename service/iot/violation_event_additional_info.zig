const ConfidenceLevel = @import("confidence_level.zig").ConfidenceLevel;

/// The details of a violation event.
pub const ViolationEventAdditionalInfo = struct {
    /// The sensitivity of anomalous behavior evaluation. Can be `Low`, `Medium`, or
    /// `High`.
    confidence_level: ?ConfidenceLevel,

    pub const json_field_names = .{
        .confidence_level = "confidenceLevel",
    };
};
