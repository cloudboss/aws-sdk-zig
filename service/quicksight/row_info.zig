/// Information about rows for a data set SPICE ingestion.
pub const RowInfo = struct {
    /// The number of rows that were not ingested.
    rows_dropped: ?i64,

    /// The number of rows that were ingested.
    rows_ingested: ?i64,

    /// The total number of rows in the dataset.
    total_rows_in_dataset: ?i64,

    pub const json_field_names = .{
        .rows_dropped = "RowsDropped",
        .rows_ingested = "RowsIngested",
        .total_rows_in_dataset = "TotalRowsInDataset",
    };
};
