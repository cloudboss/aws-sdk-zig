const SourceSchema = @import("source_schema.zig").SourceSchema;
const S3ReferenceDataSourceUpdate = @import("s3_reference_data_source_update.zig").S3ReferenceDataSourceUpdate;

/// When you update a reference data source configuration for an application,
/// this object provides all the updated values (such as the source bucket name
/// and object key name), the in-application table name that is created, and
/// updated mapping information that maps the data in the Amazon S3 object to
/// the in-application reference table that is created.
pub const ReferenceDataSourceUpdate = struct {
    /// ID of the reference data source being updated. You can use the
    /// [DescribeApplication](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_DescribeApplication.html) operation to get this value.
    reference_id: []const u8,

    /// Describes the format of the data in the streaming source, and how each data
    /// element maps to corresponding columns created in the in-application stream.
    reference_schema_update: ?SourceSchema,

    /// Describes the S3 bucket name, object key name, and IAM role that Amazon
    /// Kinesis Analytics can assume to read the Amazon S3 object on your behalf and
    /// populate the in-application reference table.
    s3_reference_data_source_update: ?S3ReferenceDataSourceUpdate,

    /// In-application table name that is created by this update.
    table_name_update: ?[]const u8,

    pub const json_field_names = .{
        .reference_id = "ReferenceId",
        .reference_schema_update = "ReferenceSchemaUpdate",
        .s3_reference_data_source_update = "S3ReferenceDataSourceUpdate",
        .table_name_update = "TableNameUpdate",
    };
};
