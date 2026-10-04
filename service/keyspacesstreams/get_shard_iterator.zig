const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ShardIteratorType = @import("shard_iterator_type.zig").ShardIteratorType;

pub const GetShardIteratorInput = struct {
    /// The sequence number of the data record in the shard from which to start
    /// reading. Required if `ShardIteratorType` is `AT_SEQUENCE_NUMBER` or
    /// `AFTER_SEQUENCE_NUMBER`. This parameter is ignored for other iterator types.
    sequence_number: ?[]const u8 = null,

    /// The identifier of the shard within the stream. The shard ID uniquely
    /// identifies a subset of the stream's data records that you want to access.
    shard_id: []const u8,

    /// Determines how the shard iterator is positioned. Must be one of the
    /// following:
    ///
    /// * `TRIM_HORIZON` - Start reading at the last untrimmed record in the shard,
    ///   which is the oldest data record in the shard.
    /// * `AT_SEQUENCE_NUMBER` - Start reading exactly from the specified sequence
    ///   number.
    /// * `AFTER_SEQUENCE_NUMBER` - Start reading right after the specified sequence
    ///   number.
    /// * `LATEST` - Start reading just after the most recent record in the shard,
    ///   so that you always read the most recent data.
    shard_iterator_type: ShardIteratorType,

    /// The Amazon Resource Name (ARN) of the stream for which to get the shard
    /// iterator. The ARN uniquely identifies the stream within Amazon Keyspaces.
    stream_arn: []const u8,

    pub const json_field_names = .{
        .sequence_number = "sequenceNumber",
        .shard_id = "shardId",
        .shard_iterator_type = "shardIteratorType",
        .stream_arn = "streamArn",
    };
};

pub const GetShardIteratorOutput = struct {
    /// The unique identifier for the shard iterator. This value is used in the
    /// `GetRecords` operation to retrieve data records from the specified shard.
    /// Each shard iterator expires 15 minutes after it is returned to the
    /// requester.
    shard_iterator: ?[]const u8 = null,

    pub const json_field_names = .{
        .shard_iterator = "shardIterator",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetShardIteratorInput, options: CallOptions) !GetShardIteratorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cassandra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetShardIteratorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cassandra-streams", "KeyspacesStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "KeyspacesStreams.GetShardIterator");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetShardIteratorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetShardIteratorOutput, body, allocator);
}
