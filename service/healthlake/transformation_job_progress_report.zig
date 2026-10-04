/// Contains progress metrics for a data transformation job, including counts of
/// files scanned, converted, and failed.
pub const TransformationJobProgressReport = struct {
    /// The total number of source files successfully converted.
    total_files_converted: i64,

    /// The total number of source files that failed conversion.
    total_files_failed: i64,

    /// The total number of source files scanned by the job.
    total_files_scanned: i64,

    /// The total number of FHIR R4 resources generated across all converted files.
    total_resources_generated: i64,

    pub const json_field_names = .{
        .total_files_converted = "TotalFilesConverted",
        .total_files_failed = "TotalFilesFailed",
        .total_files_scanned = "TotalFilesScanned",
        .total_resources_generated = "TotalResourcesGenerated",
    };
};
