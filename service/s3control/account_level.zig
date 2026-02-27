const ActivityMetrics = @import("activity_metrics.zig").ActivityMetrics;
const AdvancedCostOptimizationMetrics = @import("advanced_cost_optimization_metrics.zig").AdvancedCostOptimizationMetrics;
const AdvancedDataProtectionMetrics = @import("advanced_data_protection_metrics.zig").AdvancedDataProtectionMetrics;
const AdvancedPerformanceMetrics = @import("advanced_performance_metrics.zig").AdvancedPerformanceMetrics;
const BucketLevel = @import("bucket_level.zig").BucketLevel;
const DetailedStatusCodesMetrics = @import("detailed_status_codes_metrics.zig").DetailedStatusCodesMetrics;
const StorageLensGroupLevel = @import("storage_lens_group_level.zig").StorageLensGroupLevel;

/// A container element for the account-level Amazon S3 Storage Lens
/// configuration.
///
/// You must enable Storage Lens metrics consistently at both the account level
/// and bucket level, or your request will fail.
///
/// For more information about S3 Storage Lens, see [Assessing your storage
/// activity and usage with S3 Storage
/// Lens](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens.html) in the *Amazon S3 User Guide*. For a complete list of S3 Storage Lens metrics, see [S3 Storage Lens metrics glossary](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html) in the *Amazon S3 User Guide*.
pub const AccountLevel = struct {
    /// A container element for S3 Storage Lens activity metrics.
    activity_metrics: ?ActivityMetrics,

    /// A container element for S3 Storage Lens advanced cost-optimization metrics.
    advanced_cost_optimization_metrics: ?AdvancedCostOptimizationMetrics,

    /// A container element for S3 Storage Lens advanced data-protection metrics.
    advanced_data_protection_metrics: ?AdvancedDataProtectionMetrics,

    /// A container element for S3 Storage Lens advanced performance metrics.
    advanced_performance_metrics: ?AdvancedPerformanceMetrics,

    /// A container element for the S3 Storage Lens bucket-level configuration.
    bucket_level: BucketLevel,

    /// A container element for detailed status code metrics.
    detailed_status_codes_metrics: ?DetailedStatusCodesMetrics,

    /// A container element for S3 Storage Lens groups metrics.
    storage_lens_group_level: ?StorageLensGroupLevel,
};
