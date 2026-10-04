const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChildShard = @import("child_shard.zig").ChildShard;
const Record = @import("record.zig").Record;

pub const GetRecordsInput = struct {
    /// The maximum number of records to return. Specify a value of up to 10,000. If
    /// you
    /// specify a value that is greater than 10,000, GetRecords throws
    /// `InvalidArgumentException`. The default value is 10,000.
    limit: ?i32 = null,

    /// The position in the shard from which you want to start sequentially reading
    /// data
    /// records. A shard iterator specifies this position using the sequence number
    /// of a data
    /// record in the shard.
    shard_iterator: []const u8,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .shard_iterator = "ShardIterator",
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
    };
};

pub const GetRecordsOutput = struct {
    /// The list of the current shard's child shards, returned in the `GetRecords`
    /// API's response only when the end of the current shard is reached.
    child_shards: ?[]const ChildShard = null,

    /// The number of milliseconds the GetRecords response is from the tip
    /// of the stream, indicating how far behind current time the consumer is. A
    /// value of zero
    /// indicates that record processing is caught up, and there are no new records
    /// to process
    /// at this moment.
    millis_behind_latest: ?i64 = null,

    /// The next position in the shard from which to start sequentially reading data
    /// records.
    /// If set to `null`, the shard has been closed and the requested iterator does
    /// not return any more data.
    next_shard_iterator: ?[]const u8 = null,

    /// The data records retrieved from the shard.
    records: ?[]const Record = null,

    pub const json_field_names = .{
        .child_shards = "ChildShards",
        .millis_behind_latest = "MillisBehindLatest",
        .next_shard_iterator = "NextShardIterator",
        .records = "Records",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecordsInput, options: CallOptions) !GetRecordsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecordsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.GetRecords");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecordsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetRecordsOutput, body, allocator);
}
