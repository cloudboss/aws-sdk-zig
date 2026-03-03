const ColumnMetadata = @import("column_metadata.zig").ColumnMetadata;
const Field = @import("field.zig").Field;

/// The response elements represent the output of a request to run a SQL
/// statement against
/// a database.
pub const ExecuteStatementResponse = struct {
    /// Metadata for the columns included in the results. This field is blank if the
    /// `formatRecordsAs` parameter is set to `JSON`.
    column_metadata: ?[]const ColumnMetadata = null,

    /// A string value that represents the result set of a `SELECT` statement
    /// in JSON format. This value is only present when the `formatRecordsAs`
    /// parameter is set to `JSON`.
    ///
    /// The size limit for this field is currently 10 MB. If the JSON-formatted
    /// string representing the
    /// result set requires more than 10 MB, the call returns an error.
    formatted_records: ?[]const u8 = null,

    /// Values for fields generated during a DML request.
    ///
    /// The `generatedFields` data isn't supported by Aurora PostgreSQL.
    /// To get the values of generated fields, use the `RETURNING` clause. For
    /// more information, see [Returning Data From
    /// Modified Rows](https://www.postgresql.org/docs/10/dml-returning.html) in the
    /// PostgreSQL documentation.
    generated_fields: ?[]const Field = null,

    /// The number of records updated by the request.
    number_of_records_updated: i64 = 0,

    /// The records returned by the SQL statement. This field is blank if the
    /// `formatRecordsAs` parameter is set to `JSON`.
    records: ?[]const []const Field = null,

    pub const json_field_names = .{
        .column_metadata = "columnMetadata",
        .formatted_records = "formattedRecords",
        .generated_fields = "generatedFields",
        .number_of_records_updated = "numberOfRecordsUpdated",
        .records = "records",
    };
};
