/// A structure that describes how data is partitioned on the target.
pub const IntegrationPartition = struct {
    /// Specifies the timestamp format of the source data. Valid values are:
    ///
    /// * `epoch_sec` - Unix epoch timestamp in seconds
    ///
    /// * `epoch_milli` - Unix epoch timestamp in milliseconds
    ///
    /// * `iso` - ISO 8601 formatted timestamp
    ///
    /// Only specify `ConversionSpec` when using timestamp-based partition functions
    /// (year, month, day, or hour).
    /// Glue Zero-ETL uses this parameter to correctly transform source data into
    /// timestamp format before partitioning.
    ///
    /// Do not use high-cardinality columns with the `identity` partition function.
    /// High-cardinality columns include:
    ///
    /// * Primary keys
    ///
    /// * Timestamp fields (such as `LastModifiedTimestamp`, `CreatedDate`)
    ///
    /// * System-generated timestamps
    ///
    /// Using high-cardinality columns with identity partitioning creates many small
    /// partitions, which can significantly degrade ingestion performance.
    conversion_spec: ?[]const u8 = null,

    /// The field name used to partition data on the target. Avoid using columns
    /// that have unique values for each row (for example, `LastModifiedTimestamp`,
    /// `SystemModTimeStamp`) as the partition column. These columns are not
    /// suitable for partitioning because they create a large number of small
    /// partitions,
    /// which can lead to performance issues.
    field_name: ?[]const u8 = null,

    /// Specifies the function used to partition data on the target. The accepted
    /// values for this parameter are:
    ///
    /// * `identity` - Uses source values directly without transformation
    ///
    /// * `year` - Extracts the year from timestamp values (e.g., 2023)
    ///
    /// * `month` - Extracts the month from timestamp values (e.g., 2023-01)
    ///
    /// * `day` - Extracts the day from timestamp values (e.g., 2023-01-15)
    ///
    /// * `hour` - Extracts the hour from timestamp values (e.g., 2023-01-15-14)
    function_spec: ?[]const u8 = null,

    pub const json_field_names = .{
        .conversion_spec = "ConversionSpec",
        .field_name = "FieldName",
        .function_spec = "FunctionSpec",
    };
};
