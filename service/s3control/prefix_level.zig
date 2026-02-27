const PrefixLevelStorageMetrics = @import("prefix_level_storage_metrics.zig").PrefixLevelStorageMetrics;

/// A container for the prefix-level configuration.
pub const PrefixLevel = struct {
    /// A container for the prefix-level storage metrics for S3 Storage Lens.
    storage_metrics: PrefixLevelStorageMetrics,
};
