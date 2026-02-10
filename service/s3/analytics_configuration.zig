const AnalyticsFilter = @import("analytics_filter.zig").AnalyticsFilter;
const StorageClassAnalysis = @import("storage_class_analysis.zig").StorageClassAnalysis;

/// Specifies the configuration and any analyses for the analytics filter of an
/// Amazon S3 bucket.
pub const AnalyticsConfiguration = struct {
    /// The filter used to describe a set of objects for analyses. A filter must
    /// have exactly one prefix,
    /// one tag, or one conjunction (AnalyticsAndOperator). If no filter is
    /// provided, all objects will be
    /// considered in any analysis.
    filter: ?AnalyticsFilter,

    /// The ID that identifies the analytics configuration.
    id: []const u8,

    /// Contains data related to access patterns to be collected and made available
    /// to analyze the
    /// tradeoffs between different storage classes.
    storage_class_analysis: StorageClassAnalysis,
};
