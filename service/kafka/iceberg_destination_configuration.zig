const Catalog = @import("catalog.zig").Catalog;
const IcebergCompressionType = @import("iceberg_compression_type.zig").IcebergCompressionType;
const DeadLetterQueueS3 = @import("dead_letter_queue_s3.zig").DeadLetterQueueS3;
const DestinationTable = @import("destination_table.zig").DestinationTable;
const SchemaEvolution = @import("schema_evolution.zig").SchemaEvolution;
const TableCreation = @import("table_creation.zig").TableCreation;

/// Configuration of an Apache Iceberg destination for a channel.
pub const IcebergDestinationConfiguration = struct {
    /// Whether the destination is append-only. Must be true; updates and deletes
    /// are not supported.
    append_only: bool,

    /// The AWS Glue Data Catalog and S3 Tables warehouse used by the destination.
    catalog: ?Catalog = null,

    /// The compression codec for Iceberg table data files. Defaults to ZSTD.
    compression_type: ?IcebergCompressionType = null,

    /// The maximum time, in seconds, that records buffer in MSK before being
    /// flushed to the destination. Allowed range: 300 to 900. Default: 600.
    data_freshness_in_seconds: ?i32 = null,

    /// The Amazon S3 bucket and prefix where MSK writes records that fail to
    /// deliver.
    dead_letter_queue_s3: DeadLetterQueueS3,

    /// The destination Iceberg tables. Currently exactly one table must be
    /// specified.
    destination_table_list: []const DestinationTable,

    /// Configuration controlling whether the destination table's schema is evolved
    /// to match incoming records.
    schema_evolution: SchemaEvolution,

    /// The Amazon Resource Name (ARN) of the IAM role that MSK assumes to access
    /// the destination table, the AWS Glue Data Catalog, and the dead-letter Amazon
    /// S3 bucket.
    service_execution_role_arn: []const u8,

    /// Configuration controlling whether MSK creates the destination table if it
    /// does not already exist.
    table_creation: TableCreation,

    pub const json_field_names = .{
        .append_only = "AppendOnly",
        .catalog = "Catalog",
        .compression_type = "CompressionType",
        .data_freshness_in_seconds = "DataFreshnessInSeconds",
        .dead_letter_queue_s3 = "DeadLetterQueueS3",
        .destination_table_list = "DestinationTableList",
        .schema_evolution = "SchemaEvolution",
        .service_execution_role_arn = "ServiceExecutionRoleArn",
        .table_creation = "TableCreation",
    };
};
