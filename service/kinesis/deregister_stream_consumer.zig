const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeregisterStreamConsumerInput = struct {
    /// The ARN returned by Kinesis Data Streams when you registered the consumer.
    /// If you
    /// don't know the ARN of the consumer that you want to deregister, you can use
    /// the
    /// ListStreamConsumers operation to get a list of the descriptions of all the
    /// consumers
    /// that are currently registered with a given data stream. The description of a
    /// consumer
    /// contains its ARN.
    consumer_arn: ?[]const u8 = null,

    /// The name that you gave to the consumer.
    consumer_name: ?[]const u8 = null,

    /// The ARN of the Kinesis data stream that the consumer is registered with. For
    /// more
    /// information, see [Amazon Resource Names (ARNs) and Amazon Web Services
    /// Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kinesis-streams).
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .consumer_arn = "ConsumerARN",
        .consumer_name = "ConsumerName",
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
    };
};

pub const DeregisterStreamConsumerOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeregisterStreamConsumerInput, options: CallOptions) !DeregisterStreamConsumerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeregisterStreamConsumerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.DeregisterStreamConsumer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeregisterStreamConsumerOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
