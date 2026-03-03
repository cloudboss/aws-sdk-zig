/// An object that contains metrics about an ID mapping job, including counts of
/// input records, processed records, and mapped records between source and
/// target identifiers.
pub const IdMappingJobMetrics = struct {
    /// The number of records processed that were marked for deletion in the input
    /// file using the DELETE schema mapping field. These are the records to be
    /// removed from the ID mapping table.
    delete_records_processed: ?i32 = null,

    /// The total number of records that were input for processing.
    input_records: ?i32 = null,

    /// The number of mapped records removed.
    mapped_records_removed: ?i32 = null,

    /// The number of source records removed due to ID mapping.
    mapped_source_records_removed: ?i32 = null,

    /// The number of mapped target records removed.
    mapped_target_records_removed: ?i32 = null,

    /// The number of new mapped records.
    new_mapped_records: ?i32 = null,

    /// The number of new source records mapped.
    new_mapped_source_records: ?i32 = null,

    /// The number of new mapped target records.
    new_mapped_target_records: ?i32 = null,

    /// The number of new unique records processed in the current job run, after
    /// removing duplicates. This metric excludes deletion-related records.
    /// Duplicates are determined by the field marked as UNIQUE_ID in your schema
    /// mapping. Records sharing the same value in this field are considered
    /// duplicates. For example, if your current run processes five new records with
    /// the same UNIQUE_ID value, they would count as one new unique record in this
    /// metric.
    new_unique_records_loaded: ?i32 = null,

    /// The total number of records that did not get processed.
    records_not_processed: ?i32 = null,

    /// The total number of records that were mapped.
    total_mapped_records: ?i32 = null,

    /// The total number of mapped source records.
    total_mapped_source_records: ?i32 = null,

    /// The total number of distinct mapped target records.
    total_mapped_target_records: ?i32 = null,

    /// The total number of records that were processed.
    total_records_processed: ?i32 = null,

    /// The number of de-duplicated processed records across all runs, excluding
    /// deletion-related records. Duplicates are determined by the field marked as
    /// UNIQUE_ID in your schema mapping. Records sharing the same value in this
    /// field are considered duplicates. For example, if you specified "customer_id"
    /// as a UNIQUE_ID field and had three records with the same customer_id value,
    /// they would count as one unique record in this metric.
    unique_records_loaded: ?i32 = null,

    pub const json_field_names = .{
        .delete_records_processed = "deleteRecordsProcessed",
        .input_records = "inputRecords",
        .mapped_records_removed = "mappedRecordsRemoved",
        .mapped_source_records_removed = "mappedSourceRecordsRemoved",
        .mapped_target_records_removed = "mappedTargetRecordsRemoved",
        .new_mapped_records = "newMappedRecords",
        .new_mapped_source_records = "newMappedSourceRecords",
        .new_mapped_target_records = "newMappedTargetRecords",
        .new_unique_records_loaded = "newUniqueRecordsLoaded",
        .records_not_processed = "recordsNotProcessed",
        .total_mapped_records = "totalMappedRecords",
        .total_mapped_source_records = "totalMappedSourceRecords",
        .total_mapped_target_records = "totalMappedTargetRecords",
        .total_records_processed = "totalRecordsProcessed",
        .unique_records_loaded = "uniqueRecordsLoaded",
    };
};
