const InsightsFailureCategory = @import("insights_failure_category.zig").InsightsFailureCategory;

/// A signal indicating a detected failure within a span.
pub const InsightsFailureSignal = struct {
    /// The failure category classification for this signal.
    category: InsightsFailureCategory,

    /// The confidence score of the failure detection.
    confidence: f64,

    /// The evidence supporting the failure detection.
    evidence: []const u8,

    pub const json_field_names = .{
        .category = "category",
        .confidence = "confidence",
        .evidence = "evidence",
    };
};
