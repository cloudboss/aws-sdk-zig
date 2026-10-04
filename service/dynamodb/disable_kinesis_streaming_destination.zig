const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnableKinesisStreamingConfiguration = @import("enable_kinesis_streaming_configuration.zig").EnableKinesisStreamingConfiguration;
const DestinationStatus = @import("destination_status.zig").DestinationStatus;

pub const DisableKinesisStreamingDestinationInput = struct {
    /// The source for the Kinesis streaming information that is being enabled.
    enable_kinesis_streaming_configuration: ?EnableKinesisStreamingConfiguration = null,

    /// The ARN for a Kinesis data stream.
    stream_arn: []const u8,

    /// The name of the DynamoDB table. You can also provide the Amazon Resource
    /// Name (ARN) of the
    /// table in this parameter.
    table_name: []const u8,

    pub const json_field_names = .{
        .enable_kinesis_streaming_configuration = "EnableKinesisStreamingConfiguration",
        .stream_arn = "StreamArn",
        .table_name = "TableName",
    };
};

pub const DisableKinesisStreamingDestinationOutput = struct {
    /// The current status of the replication.
    destination_status: ?DestinationStatus = null,

    /// The destination for the Kinesis streaming information that is being enabled.
    enable_kinesis_streaming_configuration: ?EnableKinesisStreamingConfiguration = null,

    /// The ARN for the specific Kinesis data stream.
    stream_arn: ?[]const u8 = null,

    /// The name of the table being modified.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_status = "DestinationStatus",
        .enable_kinesis_streaming_configuration = "EnableKinesisStreamingConfiguration",
        .stream_arn = "StreamArn",
        .table_name = "TableName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisableKinesisStreamingDestinationInput, options: CallOptions) !DisableKinesisStreamingDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisableKinesisStreamingDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.DisableKinesisStreamingDestination");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisableKinesisStreamingDestinationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisableKinesisStreamingDestinationOutput, body, allocator);
}
