const SourceSchema = @import("source_schema.zig").SourceSchema;
const S3ReferenceDataSourceDescription = @import("s3_reference_data_source_description.zig").S3ReferenceDataSourceDescription;

/// Describes the reference data source configured for an application.
pub const ReferenceDataSourceDescription = struct {
    /// ID of the reference data source. This is the ID
    /// that Amazon Kinesis Analytics assigns when you add the reference data source
    /// to your application using the
    /// [AddApplicationReferenceDataSource](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_AddApplicationReferenceDataSource.html) operation.
    reference_id: []const u8,

    /// Describes the format of the data in the streaming source, and how each data
    /// element maps to corresponding columns created in the in-application stream.
    reference_schema: ?SourceSchema,

    /// Provides the S3 bucket name, the object key name that contains the reference
    /// data. It also provides the Amazon Resource Name (ARN) of the IAM role that
    /// Amazon Kinesis Analytics can assume to read the Amazon S3 object and
    /// populate the in-application reference table.
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
