const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KinesisDataStreamDestination = @import("kinesis_data_stream_destination.zig").KinesisDataStreamDestination;

pub const DescribeKinesisStreamingDestinationInput = struct {
    /// The name of the table being described. You can also provide the Amazon
    /// Resource Name (ARN) of the table
    /// in this parameter.
    table_name: []const u8,

    pub const json_field_names = .{
        .table_name = "TableName",
    };
};

pub const DescribeKinesisStreamingDestinationOutput = struct {
    /// The list of replica structures for the table being described.
    kinesis_data_stream_destinations: ?[]const KinesisDataStreamDestination = null,

    /// The name of the table being described.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .kinesis_data_stream_destinations = "KinesisDataStreamDestinations",
        .table_name = "TableName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeKinesisStreamingDestinationInput, options: CallOptions) !DescribeKinesisStreamingDestinationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeKinesisStreamingDestinationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.DescribeKinesisStreamingDestination");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeKinesisStreamingDestinationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeKinesisStreamingDestinationOutput, body, allocator);
}
