const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StartingPosition = @import("starting_position.zig").StartingPosition;
const SubscribeToShardEventStream = @import("subscribe_to_shard_event_stream.zig").SubscribeToShardEventStream;

pub const SubscribeToShardInput = struct {
    /// For this parameter, use the value you obtained when you called
    /// RegisterStreamConsumer.
    consumer_arn: []const u8,

    /// The ID of the shard you want to subscribe to. To see a list of all the
    /// shards for a
    /// given stream, use ListShards.
    shard_id: []const u8,

    /// The starting position in the data stream from which to start streaming.
    starting_position: StartingPosition,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .consumer_arn = "ConsumerARN",
        .shard_id = "ShardId",
        .starting_position = "StartingPosition",
        .stream_id = "StreamId",
    };
};

pub const SubscribeToShardOutput = struct {
    event_stream: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *SubscribeToShardOutput) void {
        self.event_stream.deinit();
    }

    pub const json_field_names = .{
        .event_stream = "EventStream",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SubscribeToShardInput, options: CallOptions) !SubscribeToShardOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesis", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    stream_resp.deinitHeaders();
    errdefer stream_resp.body.deinit();

    const event_stream = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body);
    return .{ .event_stream = event_stream };
}

fn serializeRequest(allocator: std.mem.Allocator, input: SubscribeToShardInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.SubscribeToShard");

    return request;
}
