const SensitivityAggregations = @import("sensitivity_aggregations.zig").SensitivityAggregations;

/// Provides aggregated statistical data for sensitive data discovery metrics
/// that apply to S3 buckets, grouped by bucket sensitivity score
/// (sensitivityScore). If automated sensitive data discovery is currently
/// disabled for your account, the value for most of these metrics is 0.
pub const BucketStatisticsBySensitivity = struct {
    /// The aggregated statistical data for all buckets that have a sensitivity
    /// score of -1.
    classification_error: ?SensitivityAggregations = null,

    /// The aggregated statistical data for all buckets that have a sensitivity
    /// score of 50.
    not_classified: ?SensitivityAggregations = null,

    /// The aggregated statistical data for all buckets that have a sensitivity
    /// score of 1-49.
    not_sensitive: ?SensitivityAggregations = null,

    /// The aggregated statistical data for all buckets that have a sensitivity
    /// score of 51-100.
    sensitive: ?SensitivityAggregations = null,

    pub const json_field_names = .{
        .classification_error = "classificationError",
        .not_classified = "notClassified",
        .not_sensitive = "notSensitive",
        .sensitive = "sensitive",
    };
};
