const DifferentialPrivacyAggregationType = @import("differential_privacy_aggregation_type.zig").DifferentialPrivacyAggregationType;

/// Provides an estimate of the number of aggregation functions that the member
/// who can query can run given the epsilon and noise parameters.
pub const DifferentialPrivacyPreviewAggregation = struct {
    /// The maximum number of aggregations that the member who can query can run
    /// given the epsilon and noise parameters.
    max_count: i32,

    /// The type of aggregation function.
    @"type": DifferentialPrivacyAggregationType,

    pub const json_field_names = .{
        .max_count = "maxCount",
        .@"type" = "type",
    };
};
