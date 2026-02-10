const AnalyticsExportDestination = @import("analytics_export_destination.zig").AnalyticsExportDestination;
const StorageClassAnalysisSchemaVersion = @import("storage_class_analysis_schema_version.zig").StorageClassAnalysisSchemaVersion;

/// Container for data related to the storage class analysis for an Amazon S3
/// bucket for export.
pub const StorageClassAnalysisDataExport = struct {
    /// The place to store the data for an analysis.
    destination: AnalyticsExportDestination,

    /// The version of the output schema to use when exporting data. Must be `V_1`.
    output_schema_version: StorageClassAnalysisSchemaVersion,
};
