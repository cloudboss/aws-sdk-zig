const BufferingHints = @import("buffering_hints.zig").BufferingHints;
const CatalogConfiguration = @import("catalog_configuration.zig").CatalogConfiguration;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const DestinationTableConfiguration = @import("destination_table_configuration.zig").DestinationTableConfiguration;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const RetryOptions = @import("retry_options.zig").RetryOptions;
const IcebergS3BackupMode = @import("iceberg_s3_backup_mode.zig").IcebergS3BackupMode;
const S3DestinationDescription = @import("s3_destination_description.zig").S3DestinationDescription;
const SchemaEvolutionConfiguration = @import("schema_evolution_configuration.zig").SchemaEvolutionConfiguration;
const TableCreationConfiguration = @import("table_creation_configuration.zig").TableCreationConfiguration;

/// Describes a destination in Apache Iceberg Tables.
pub const IcebergDestinationDescription = struct {
    /// Describes whether all incoming data for this delivery stream will be append
    /// only
    /// (inserts only and not for updates and deletes) for Iceberg delivery. This
    /// feature is only
    /// applicable for Apache Iceberg Tables.
    ///
    /// The default value is false. If you set this value to true, Firehose
    /// automatically
    /// increases the throughput limit of a stream based on the throttling levels of
    /// the stream. If
    /// you set this parameter to true for a stream with updates and deletes, you
    /// will see out of
    /// order delivery.
    append_only: ?bool,

    buffering_hints: ?BufferingHints,

    /// Configuration describing where the destination Iceberg tables are persisted.
    catalog_configuration: ?CatalogConfiguration,

    cloud_watch_logging_options: ?CloudWatchLoggingOptions,

    /// Provides a list of `DestinationTableConfigurations` which Firehose uses
    /// to deliver data to Apache Iceberg Tables. Firehose will write data with
    /// insert if table specific configuration is not provided here.
    destination_table_configuration_list: ?[]const DestinationTableConfiguration,

    processing_configuration: ?ProcessingConfiguration,

    retry_options: ?RetryOptions,

    /// The Amazon Resource Name (ARN) of the IAM role to be assumed by Firehose for
    /// calling Apache Iceberg Tables.
    role_arn: ?[]const u8,

    /// Describes how Firehose will backup records. Currently,Firehose only supports
    /// `FailedDataOnly`.
    s3_backup_mode: ?IcebergS3BackupMode,

    s3_destination_description: ?S3DestinationDescription,

    /// The description of automatic schema evolution configuration.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    schema_evolution_configuration: ?SchemaEvolutionConfiguration,

    /// The description of table creation configuration.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    table_creation_configuration: ?TableCreationConfiguration,

    pub const json_field_names = .{
        .append_only = "AppendOnly",
        .buffering_hints = "BufferingHints",
        .catalog_configuration = "CatalogConfiguration",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .destination_table_configuration_list = "DestinationTableConfigurationList",
        .processing_configuration = "ProcessingConfiguration",
        .retry_options = "RetryOptions",
        .role_arn = "RoleARN",
        .s3_backup_mode = "S3BackupMode",
        .s3_destination_description = "S3DestinationDescription",
        .schema_evolution_configuration = "SchemaEvolutionConfiguration",
        .table_creation_configuration = "TableCreationConfiguration",
    };
};
