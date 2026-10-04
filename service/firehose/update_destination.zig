const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AmazonOpenSearchServerlessDestinationUpdate = @import("amazon_open_search_serverless_destination_update.zig").AmazonOpenSearchServerlessDestinationUpdate;
const AmazonopensearchserviceDestinationUpdate = @import("amazonopensearchservice_destination_update.zig").AmazonopensearchserviceDestinationUpdate;
const ElasticsearchDestinationUpdate = @import("elasticsearch_destination_update.zig").ElasticsearchDestinationUpdate;
const ExtendedS3DestinationUpdate = @import("extended_s3_destination_update.zig").ExtendedS3DestinationUpdate;
const HttpEndpointDestinationUpdate = @import("http_endpoint_destination_update.zig").HttpEndpointDestinationUpdate;
const IcebergDestinationUpdate = @import("iceberg_destination_update.zig").IcebergDestinationUpdate;
const RedshiftDestinationUpdate = @import("redshift_destination_update.zig").RedshiftDestinationUpdate;
const S3DestinationUpdate = @import("s3_destination_update.zig").S3DestinationUpdate;
const SnowflakeDestinationUpdate = @import("snowflake_destination_update.zig").SnowflakeDestinationUpdate;
const SplunkDestinationUpdate = @import("splunk_destination_update.zig").SplunkDestinationUpdate;

pub const UpdateDestinationInput = struct {
    /// Describes an update for a destination in the Serverless offering for Amazon
    /// OpenSearch
    /// Service.
    amazon_open_search_serverless_destination_update: ?AmazonOpenSearchServerlessDestinationUpdate = null,

    /// Describes an update for a destination in Amazon OpenSearch Service.
    amazonopensearchservice_destination_update: ?AmazonopensearchserviceDestinationUpdate = null,

    /// Obtain this value from the `VersionId` result of DeliveryStreamDescription.
    /// This value is required, and helps the service
    /// perform conditional operations. For example, if there is an interleaving
    /// update and this
    /// value is null, then the update destination fails. After the update is
    /// successful, the
    /// `VersionId` value is updated. The service then performs a merge of the old
    /// configuration with the new configuration.
    current_delivery_stream_version_id: []const u8,

    /// The name of the Firehose stream.
    delivery_stream_name: []const u8,

    /// The ID of the destination.
    destination_id: []const u8,

    /// Describes an update for a destination in Amazon OpenSearch Service.
    elasticsearch_destination_update: ?ElasticsearchDestinationUpdate = null,

    /// Describes an update for a destination in Amazon S3.
    extended_s3_destination_update: ?ExtendedS3DestinationUpdate = null,

    /// Describes an update to the specified HTTP endpoint destination.
    http_endpoint_destination_update: ?HttpEndpointDestinationUpdate = null,

    /// Describes an update for a destination in Apache Iceberg Tables.
    iceberg_destination_update: ?IcebergDestinationUpdate = null,

    /// Describes an update for a destination in Amazon Redshift.
    redshift_destination_update: ?RedshiftDestinationUpdate = null,

    /// [Deprecated] Describes an update for a destination in Amazon S3.
    s3_destination_update: ?S3DestinationUpdate = null,

    /// Update to the Snowflake destination configuration settings.
    snowflake_destination_update: ?SnowflakeDestinationUpdate = null,

    /// Describes an update for a destination in Splunk.
    splunk_destination_update: ?SplunkDestinationUpdate = null,

    pub const json_field_names = .{
        .amazon_open_search_serverless_destination_update = "AmazonOpenSearchServerlessDestinationUpdate",
        .amazonopensearchservice_destination_update = "AmazonopensearchserviceDestinationUpdate",
        .current_delivery_stream_version_id = "CurrentDeliveryStreamVersionId",
        .delivery_stream_name = "DeliveryStreamName",
        .destination_id = "DestinationId",
        .elasticsearch_destination_update = "ElasticsearchDestinationUpdate",
        .extended_s3_destination_update = "ExtendedS3DestinationUpdate",
        .http_endpoint_destination_update = "HttpEndpointDestinationUpdate",
        .iceberg_destination_update = "IcebergDestinationUpdate",
        .redshift_destination_update = "RedshiftDestinationUpdate",
        .s3_destination_update = "S3DestinationUpdate",
        .snowflake_destination_update = "SnowflakeDestinationUpdate",
        .splunk_destination_update = "SplunkDestinationUpdate",
    };
};

pub const UpdateDestinationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDestinationInput, options: CallOptions) !UpdateDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "firehose", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("firehose", "Firehose", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Firehose_20150804.UpdateDestination");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDestinationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
