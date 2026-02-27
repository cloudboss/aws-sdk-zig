/// Statistics about the execution of an export job.
pub const ExportStatistics = struct {
    /// The number of records that were exported to the final export file.
    ///
    /// This value might not be available for all export source types
    exported_records_count: ?i32,

    /// The number of records that were processed to generate the final export file.
    processed_records_count: ?i32,

    pub const json_field_names = .{
        .exported_records_count = "ExportedRecordsCount",
        .processed_records_count = "ProcessedRecordsCount",
    };
};
