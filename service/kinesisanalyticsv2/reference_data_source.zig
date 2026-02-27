const SourceSchema = @import("source_schema.zig").SourceSchema;
const S3ReferenceDataSource = @import("s3_reference_data_source.zig").S3ReferenceDataSource;

/// For a SQL-based Kinesis Data Analytics application, describes the reference
/// data
/// source by providing the source information (Amazon S3 bucket name and object
/// key name), the
/// resulting in-application table name that is created, and the necessary
/// schema to map the data
/// elements in the Amazon S3 object to the in-application table.
pub const ReferenceDataSource = struct {
    /// Describes the format of the data in the streaming source, and how each data
    /// element maps to corresponding columns created in the in-application stream.
    reference_schema: SourceSchema,

    /// Identifies the S3 bucket and object that contains the reference data.
    ///
    /// A SQL-based Kinesis Data Analytics application loads reference data only
    /// once. If the data changes, you call the UpdateApplication operation to
    /// trigger reloading of data into your application.
    s3_reference_data_source: ?S3ReferenceDataSource,

    /// The name of the in-application table to create.
    table_name: []const u8,

    pub const json_field_names = .{
        .reference_schema = "ReferenceSchema",
        .s3_reference_data_source = "S3ReferenceDataSource",
        .table_name = "TableName",
    };
};
