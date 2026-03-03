const SourceSchema = @import("source_schema.zig").SourceSchema;
const S3ReferenceDataSourceDescription = @import("s3_reference_data_source_description.zig").S3ReferenceDataSourceDescription;

/// For a SQL-based Kinesis Data Analytics application, describes the reference
/// data
/// source configured for an application.
pub const ReferenceDataSourceDescription = struct {
    /// The ID of the reference data source. This is the ID that Kinesis Data
    /// Analytics assigns
    /// when you add the reference data source to your application using the
    /// CreateApplication or UpdateApplication operation.
    reference_id: []const u8,

    /// Describes the format of the data in the streaming source, and how each data
    /// element maps to corresponding columns created in the in-application stream.
    reference_schema: ?SourceSchema = null,

    /// Provides the Amazon S3 bucket name, the object key name that contains the
    /// reference data.
    s3_reference_data_source_description: S3ReferenceDataSourceDescription,

    /// The in-application table name created by the specific reference data source
    /// configuration.
    table_name: []const u8,

    pub const json_field_names = .{
        .reference_id = "ReferenceId",
        .reference_schema = "ReferenceSchema",
        .s3_reference_data_source_description = "S3ReferenceDataSourceDescription",
        .table_name = "TableName",
    };
};
