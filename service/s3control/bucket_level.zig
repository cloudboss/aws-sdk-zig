const ActivityMetrics = @import("activity_metrics.zig").ActivityMetrics;
const AdvancedCostOptimizationMetrics = @import("advanced_cost_optimization_metrics.zig").AdvancedCostOptimizationMetrics;
const AdvancedDataProtectionMetrics = @import("advanced_data_protection_metrics.zig").AdvancedDataProtectionMetrics;
const AdvancedPerformanceMetrics = @import("advanced_performance_metrics.zig").AdvancedPerformanceMetrics;
const DetailedStatusCodesMetrics = @import("detailed_status_codes_metrics.zig").DetailedStatusCodesMetrics;
const PrefixLevel = @import("prefix_level.zig").PrefixLevel;

/// A container for the bucket-level configuration for Amazon S3 Storage Lens.
///
/// For more information about S3 Storage Lens, see [Assessing your storage
/// activity and usage with S3 Storage
/// Lens](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens.html) in the *Amazon S3 User Guide*.
pub const BucketLevel = struct {
    /// A container for the bucket-level activity metrics for S3 Storage Lens.
    activity_metrics: ?ActivityMetrics = null,

    /// A container for bucket-level advanced cost-optimization metrics for S3
    /// Storage Lens.
    advanced_cost_optimization_metrics: ?AdvancedCostOptimizationMetrics = null,

    /// A container for bucket-level advanced data-protection metrics for S3 Storage
    /// Lens.
    advanced_data_protection_metrics: ?AdvancedDataProtectionMetrics = null,

    /// A container for bucket-level advanced performance metrics for S3 Storage
    /// Lens.
    advanced_performance_metrics: ?AdvancedPerformanceMetrics = null,

    /// A container for bucket-level detailed status code metrics for S3 Storage
    /// Lens.
    detailed_status_codes_metrics: ?DetailedStatusCodesMetrics = null,

    /// A container for the prefix-level metrics for S3 Storage Lens.
    prefix_level: ?PrefixLevel = null,
};
