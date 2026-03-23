const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AmazonOpenSearchServerlessDestinationConfiguration = @import("amazon_open_search_serverless_destination_configuration.zig").AmazonOpenSearchServerlessDestinationConfiguration;
const AmazonopensearchserviceDestinationConfiguration = @import("amazonopensearchservice_destination_configuration.zig").AmazonopensearchserviceDestinationConfiguration;
const DatabaseSourceConfiguration = @import("database_source_configuration.zig").DatabaseSourceConfiguration;
const DeliveryStreamEncryptionConfigurationInput = @import("delivery_stream_encryption_configuration_input.zig").DeliveryStreamEncryptionConfigurationInput;
const DeliveryStreamType = @import("delivery_stream_type.zig").DeliveryStreamType;
const DirectPutSourceConfiguration = @import("direct_put_source_configuration.zig").DirectPutSourceConfiguration;
const ElasticsearchDestinationConfiguration = @import("elasticsearch_destination_configuration.zig").ElasticsearchDestinationConfiguration;
const ExtendedS3DestinationConfiguration = @import("extended_s3_destination_configuration.zig").ExtendedS3DestinationConfiguration;
const HttpEndpointDestinationConfiguration = @import("http_endpoint_destination_configuration.zig").HttpEndpointDestinationConfiguration;
const IcebergDestinationConfiguration = @import("iceberg_destination_configuration.zig").IcebergDestinationConfiguration;
const KinesisStreamSourceConfiguration = @import("kinesis_stream_source_configuration.zig").KinesisStreamSourceConfiguration;
const MSKSourceConfiguration = @import("msk_source_configuration.zig").MSKSourceConfiguration;
const RedshiftDestinationConfiguration = @import("redshift_destination_configuration.zig").RedshiftDestinationConfiguration;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;
const SnowflakeDestinationConfiguration = @import("snowflake_destination_configuration.zig").SnowflakeDestinationConfiguration;
const SplunkDestinationConfiguration = @import("splunk_destination_configuration.zig").SplunkDestinationConfiguration;
const Tag = @import("tag.zig").Tag;

pub const CreateDeliveryStreamInput = struct {
    /// The destination in the Serverless offering for Amazon OpenSearch Service.
    /// You can
    /// specify only one destination.
    amazon_open_search_serverless_destination_configuration: ?AmazonOpenSearchServerlessDestinationConfiguration = null,

    /// The destination in Amazon OpenSearch Service. You can specify only one
    /// destination.
    amazonopensearchservice_destination_configuration: ?AmazonopensearchserviceDestinationConfiguration = null,

    /// The top level object for configuring streams with database as a source.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    database_source_configuration: ?DatabaseSourceConfiguration = null,

    /// Used to specify the type and Amazon Resource Name (ARN) of the KMS key
    /// needed for
    /// Server-Side Encryption (SSE).
    delivery_stream_encryption_configuration_input: ?DeliveryStreamEncryptionConfigurationInput = null,

    /// The name of the Firehose stream. This name must be unique per Amazon Web
    /// Services
    /// account in the same Amazon Web Services Region. If the Firehose streams are
    /// in different
    /// accounts or different Regions, you can have multiple Firehose streams with
    /// the same
    /// name.
    delivery_stream_name: []const u8,

    /// The Firehose stream type. This parameter can be one of the following
    /// values:
    ///
    /// * `DirectPut`: Provider applications access the Firehose stream
    /// directly.
    ///
    /// * `KinesisStreamAsSource`: The Firehose stream uses a Kinesis data
    /// stream as a source.
    delivery_stream_type: ?DeliveryStreamType = null,

    /// The structure that configures parameters such as `ThroughputHintInMBs` for a
    /// stream configured with Direct PUT as a source.
    direct_put_source_configuration: ?DirectPutSourceConfiguration = null,

    /// The destination in Amazon OpenSearch Service. You can specify only one
    /// destination.
    elasticsearch_destination_configuration: ?ElasticsearchDestinationConfiguration = null,

    /// The destination in Amazon S3. You can specify only one destination.
    extended_s3_destination_configuration: ?ExtendedS3DestinationConfiguration = null,

    /// Enables configuring Kinesis Firehose to deliver data to any HTTP endpoint
    /// destination.
    /// You can specify only one destination.
    http_endpoint_destination_configuration: ?HttpEndpointDestinationConfiguration = null,

    /// Configure Apache Iceberg Tables destination.
    iceberg_destination_configuration: ?IcebergDestinationConfiguration = null,

    /// When a Kinesis data stream is used as the source for the Firehose stream, a
    /// KinesisStreamSourceConfiguration containing the Kinesis data stream Amazon
    /// Resource Name (ARN) and the role ARN for the source stream.
    kinesis_stream_source_configuration: ?KinesisStreamSourceConfiguration = null,

    msk_source_configuration: ?MSKSourceConfiguration = null,

    /// The destination in Amazon Redshift. You can specify only one destination.
    redshift_destination_configuration: ?RedshiftDestinationConfiguration = null,

    /// [Deprecated]
    /// The destination in Amazon S3. You can specify only one destination.
    s3_destination_configuration: ?S3DestinationConfiguration = null,

    /// Configure Snowflake destination
    snowflake_destination_configuration: ?SnowflakeDestinationConfiguration = null,

    /// The destination in Splunk. You can specify only one destination.
    splunk_destination_configuration: ?SplunkDestinationConfiguration = null,

    /// A set of tags to assign to the Firehose stream. A tag is a key-value pair
    /// that you can
    /// define and assign to Amazon Web Services resources. Tags are metadata. For
    /// example, you can
    /// add friendly names and descriptions or other types of information that can
    /// help you
    /// distinguish the Firehose stream. For more information about tags, see [Using
    /// Cost Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the Amazon Web Services Billing and Cost Management User
    /// Guide.
    ///
    /// You can specify up to 50 tags when creating a Firehose stream.
    ///
    /// If you specify tags in the `CreateDeliveryStream` action, Amazon Data
    /// Firehose performs an additional authorization on the
    /// `firehose:TagDeliveryStream` action to verify if users have permissions to
    /// create tags. If you do not provide this permission, requests to create new
    /// Firehose streams
    /// with IAM resource tags will fail with an `AccessDeniedException` such as
    /// following.
    ///
    /// **AccessDeniedException**
    ///
    /// User: arn:aws:sts::x:assumed-role/x/x is not authorized to perform:
    /// firehose:TagDeliveryStream on resource:
    /// arn:aws:firehose:us-east-1:x:deliverystream/x with an explicit deny in an
    /// identity-based policy.
    ///
    /// For an example IAM policy, see [Tag
    /// example.](https://docs.aws.amazon.com/firehose/latest/APIReference/API_CreateDeliveryStream.html#API_CreateDeliveryStream_Examples)
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .amazon_open_search_serverless_destination_configuration = "AmazonOpenSearchServerlessDestinationConfiguration",
        .amazonopensearchservice_destination_configuration = "AmazonopensearchserviceDestinationConfiguration",
        .database_source_configuration = "DatabaseSourceConfiguration",
        .delivery_stream_encryption_configuration_input = "DeliveryStreamEncryptionConfigurationInput",
        .delivery_stream_name = "DeliveryStreamName",
        .delivery_stream_type = "DeliveryStreamType",
        .direct_put_source_configuration = "DirectPutSourceConfiguration",
        .elasticsearch_destination_configuration = "ElasticsearchDestinationConfiguration",
        .extended_s3_destination_configuration = "ExtendedS3DestinationConfiguration",
        .http_endpoint_destination_configuration = "HttpEndpointDestinationConfiguration",
        .iceberg_destination_configuration = "IcebergDestinationConfiguration",
        .kinesis_stream_source_configuration = "KinesisStreamSourceConfiguration",
        .msk_source_configuration = "MSKSourceConfiguration",
        .redshift_destination_configuration = "RedshiftDestinationConfiguration",
        .s3_destination_configuration = "S3DestinationConfiguration",
        .snowflake_destination_configuration = "SnowflakeDestinationConfiguration",
        .splunk_destination_configuration = "SplunkDestinationConfiguration",
        .tags = "Tags",
    };
};

pub const CreateDeliveryStreamOutput = struct {
    /// The ARN of the Firehose stream.
    delivery_stream_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .delivery_stream_arn = "DeliveryStreamARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeliveryStreamInput, options: CallOptions) !CreateDeliveryStreamOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeliveryStreamInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Firehose_20150804.CreateDeliveryStream");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeliveryStreamOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDeliveryStreamOutput, body, allocator);
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
