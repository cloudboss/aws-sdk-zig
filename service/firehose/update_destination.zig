const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "firehose");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("firehose", "Firehose", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKMSResourceException")) {
        return .{ .arena = arena, .kind = .{ .invalid_kms_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSourceException")) {
        return .{ .arena = arena, .kind = .{ .invalid_source_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
