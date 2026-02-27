const AmazonOpenSearchServerlessDestinationDescription = @import("amazon_open_search_serverless_destination_description.zig").AmazonOpenSearchServerlessDestinationDescription;
const AmazonopensearchserviceDestinationDescription = @import("amazonopensearchservice_destination_description.zig").AmazonopensearchserviceDestinationDescription;
const ElasticsearchDestinationDescription = @import("elasticsearch_destination_description.zig").ElasticsearchDestinationDescription;
const ExtendedS3DestinationDescription = @import("extended_s3_destination_description.zig").ExtendedS3DestinationDescription;
const HttpEndpointDestinationDescription = @import("http_endpoint_destination_description.zig").HttpEndpointDestinationDescription;
const IcebergDestinationDescription = @import("iceberg_destination_description.zig").IcebergDestinationDescription;
const RedshiftDestinationDescription = @import("redshift_destination_description.zig").RedshiftDestinationDescription;
const S3DestinationDescription = @import("s3_destination_description.zig").S3DestinationDescription;
const SnowflakeDestinationDescription = @import("snowflake_destination_description.zig").SnowflakeDestinationDescription;
const SplunkDestinationDescription = @import("splunk_destination_description.zig").SplunkDestinationDescription;

/// Describes the destination for a Firehose stream.
pub const DestinationDescription = struct {
    /// The destination in the Serverless offering for Amazon OpenSearch Service.
    amazon_open_search_serverless_destination_description: ?AmazonOpenSearchServerlessDestinationDescription,

    /// The destination in Amazon OpenSearch Service.
    amazonopensearchservice_destination_description: ?AmazonopensearchserviceDestinationDescription,

    /// The ID of the destination.
    destination_id: []const u8,

    /// The destination in Amazon OpenSearch Service.
    elasticsearch_destination_description: ?ElasticsearchDestinationDescription,

    /// The destination in Amazon S3.
    extended_s3_destination_description: ?ExtendedS3DestinationDescription,

    /// Describes the specified HTTP endpoint destination.
    http_endpoint_destination_description: ?HttpEndpointDestinationDescription,

    /// Describes a destination in Apache Iceberg Tables.
    iceberg_destination_description: ?IcebergDestinationDescription,

    /// The destination in Amazon Redshift.
    redshift_destination_description: ?RedshiftDestinationDescription,

    /// [Deprecated] The destination in Amazon S3.
    s3_destination_description: ?S3DestinationDescription,

    /// Optional description for the destination
    snowflake_destination_description: ?SnowflakeDestinationDescription,

    /// The destination in Splunk.
    splunk_destination_description: ?SplunkDestinationDescription,

    pub const json_field_names = .{
        .amazon_open_search_serverless_destination_description = "AmazonOpenSearchServerlessDestinationDescription",
        .amazonopensearchservice_destination_description = "AmazonopensearchserviceDestinationDescription",
        .destination_id = "DestinationId",
        .elasticsearch_destination_description = "ElasticsearchDestinationDescription",
        .extended_s3_destination_description = "ExtendedS3DestinationDescription",
        .http_endpoint_destination_description = "HttpEndpointDestinationDescription",
        .iceberg_destination_description = "IcebergDestinationDescription",
        .redshift_destination_description = "RedshiftDestinationDescription",
        .s3_destination_description = "S3DestinationDescription",
        .snowflake_destination_description = "SnowflakeDestinationDescription",
        .splunk_destination_description = "SplunkDestinationDescription",
    };
};
