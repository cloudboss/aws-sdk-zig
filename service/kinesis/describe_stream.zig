const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamDescription = @import("stream_description.zig").StreamDescription;

pub const DescribeStreamInput = struct {
    /// The shard ID of the shard to start with.
    ///
    /// Specify this parameter to indicate that you want to describe the stream
    /// starting with
    /// the shard whose ID immediately follows `ExclusiveStartShardId`.
    ///
    /// If you don't specify this parameter, the default behavior for
    /// `DescribeStream` is to describe the stream starting with the first shard
    /// in the stream.
    exclusive_start_shard_id: ?[]const u8 = null,

    /// The maximum number of shards to return in a single call. The default value
    /// is 100. If
    /// you specify a value greater than 100, at most 100 results are returned.
    limit: ?i32 = null,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// The name of the stream to describe.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .exclusive_start_shard_id = "ExclusiveStartShardId",
        .limit = "Limit",
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
        .stream_name = "StreamName",
    };
};

pub const DescribeStreamOutput = struct {
    /// The current status of the stream, the stream Amazon Resource Name (ARN), an
    /// array of
    /// shard objects that comprise the stream, and whether there are more shards
    /// available.
    stream_description: ?StreamDescription = null,

    pub const json_field_names = .{
        .stream_description = "StreamDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStreamInput, options: CallOptions) !DescribeStreamOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStreamInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.DescribeStream");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStreamOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeStreamOutput, body, allocator);
}
