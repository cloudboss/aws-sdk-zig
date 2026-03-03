const StorageClassAnalysisDataExport = @import("storage_class_analysis_data_export.zig").StorageClassAnalysisDataExport;

/// Specifies data related to access patterns to be collected and made available
/// to analyze the
/// tradeoffs between different storage classes for an Amazon S3 bucket.
pub const StorageClassAnalysis = struct {
    /// Specifies how data related to the storage class analysis for an Amazon S3
    /// bucket should be
    /// exported.
    data_export: ?StorageClassAnalysisDataExport = null,
};
