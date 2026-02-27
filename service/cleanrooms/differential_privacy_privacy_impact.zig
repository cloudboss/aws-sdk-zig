const DifferentialPrivacyPreviewAggregation = @import("differential_privacy_preview_aggregation.zig").DifferentialPrivacyPreviewAggregation;

/// Information about the number of aggregation functions that the member who
/// can query can run given the epsilon and noise parameters.
pub const DifferentialPrivacyPrivacyImpact = struct {
    /// The number of aggregation functions that you can perform.
    aggregations: []const DifferentialPrivacyPreviewAggregation,

    pub const json_field_names = .{
        .aggregations = "aggregations",
    };
};
