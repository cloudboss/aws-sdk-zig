/// An object containing `inputRecords`, `totalRecordsProcessed`, `matchIDs`,
/// and `recordsNotProcessed`.
pub const JobMetrics = struct {
    /// The number of records processed that were marked for deletion (`DELETE` =
    /// True) in the input file. This metric tracks records flagged for removal
    /// during the job execution.
    delete_records_processed: ?i32,

    /// The total number of input records.
    input_records: ?i32,

    /// The total number of `matchID`s generated.
    match_i_ds: ?i32,

    /// The total number of records that did not get processed.
    records_not_processed: ?i32,

    /// The total number of records processed.
    total_records_processed: ?i32,

    pub const json_field_names = .{
        .delete_records_processed = "deleteRecordsProcessed",
        .input_records = "inputRecords",
        .match_i_ds = "matchIDs",
        .records_not_processed = "recordsNotProcessed",
        .total_records_processed = "totalRecordsProcessed",
    };
};
