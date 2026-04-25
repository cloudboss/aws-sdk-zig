/// Contains metadata about a lookup table returned by `DescribeLookupTables`.
pub const LookupTable = struct {
    /// The description of the lookup table.
    description: ?[]const u8 = null,

    /// The ARN of the KMS key used to encrypt the lookup table data, if
    /// applicable.
    kms_key_id: ?[]const u8 = null,

    /// The time when the lookup table was last updated, expressed as the number of
    /// milliseconds after `Jan 1, 1970 00:00:00 UTC`.
    last_updated_time: ?i64 = null,

    /// The ARN of the lookup table.
    lookup_table_arn: ?[]const u8 = null,

    /// The name of the lookup table.
    lookup_table_name: ?[]const u8 = null,

    /// The number of data rows in the lookup table, excluding the header row.
    records_count: ?i64 = null,

    /// The size of the lookup table in bytes.
    size_bytes: ?i64 = null,

    /// The column headers from the first row of the CSV file.
    table_fields: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .last_updated_time = "lastUpdatedTime",
        .lookup_table_arn = "lookupTableArn",
        .lookup_table_name = "lookupTableName",
        .records_count = "recordsCount",
        .size_bytes = "sizeBytes",
        .table_fields = "tableFields",
    };
};
