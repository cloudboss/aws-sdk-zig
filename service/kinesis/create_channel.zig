const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelEncryptionConfiguration = @import("channel_encryption_configuration.zig").ChannelEncryptionConfiguration;
const ChannelLoggingConfiguration = @import("channel_logging_configuration.zig").ChannelLoggingConfiguration;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;
const S3TablesDestinationConfiguration = @import("s3_tables_destination_configuration.zig").S3TablesDestinationConfiguration;
const ChannelStreamConfiguration = @import("channel_stream_configuration.zig").ChannelStreamConfiguration;
const ChannelDescription = @import("channel_description.zig").ChannelDescription;

pub const CreateChannelInput = struct {
    /// The name of the channel. The name is unique within your Amazon Web Services
    /// account and Amazon Web Services Region.
    channel_name: []const u8,

    /// The server-side encryption configuration that uses an Amazon Web Services
    /// KMS key to encrypt data delivered to the destination.
    encryption_configuration: ?ChannelEncryptionConfiguration = null,

    /// The Amazon CloudWatch Logs configuration for the channel.
    logging_configuration: ?ChannelLoggingConfiguration = null,

    /// The configuration for delivery to a general purpose Amazon S3 bucket.
    /// Specify this parameter when `S3TablesDestinationConfiguration` is not
    /// specified.
    s3_destination_configuration: ?S3DestinationConfiguration = null,

    /// The configuration for delivery to streaming tables on Apache Iceberg in
    /// Amazon S3 Tables. Specify this parameter when `S3DestinationConfiguration`
    /// is not specified.
    s3_tables_destination_configuration: ?S3TablesDestinationConfiguration = null,

    /// The Amazon Resource Name (ARN) of the IAM role that Amazon Kinesis Data
    /// Streams assumes to write records to the destination.
    service_execution_role_arn: []const u8,

    /// The source stream configuration for the channel. Currently, one stream is
    /// supported per channel.
    stream_configuration_list: []const ChannelStreamConfiguration,

    /// A set of key-value pairs to assign to the channel. A tag consists of a
    /// required key and an optional value.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
        .encryption_configuration = "EncryptionConfiguration",
        .logging_configuration = "LoggingConfiguration",
        .s3_destination_configuration = "S3DestinationConfiguration",
        .s3_tables_destination_configuration = "S3TablesDestinationConfiguration",
        .service_execution_role_arn = "ServiceExecutionRoleARN",
        .stream_configuration_list = "StreamConfigurationList",
        .tags = "Tags",
    };
};

pub const CreateChannelOutput = struct {
    /// The configuration and current status of the channel, including its ARN,
    /// destination configuration, and lifecycle state. Immediately after creation,
    /// the state is `CREATING`.
    channel_description: ?ChannelDescription = null,

    pub const json_field_names = .{
        .channel_description = "ChannelDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChannelInput, options: CallOptions) !CreateChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesis", "Kinesis", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.CreateChannel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChannelOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateChannelOutput, body, allocator);
}
