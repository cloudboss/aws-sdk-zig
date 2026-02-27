const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ShardIteratorType = @import("shard_iterator_type.zig").ShardIteratorType;

pub const GetShardIteratorInput = struct {
    /// The sequence number of a stream record in the shard from which to start
    /// reading.
    sequence_number: ?[]const u8 = null,

    /// The identifier of the shard. The iterator will be returned for this shard
    /// ID.
    shard_id: []const u8,

    /// Determines how the shard iterator is used to start reading stream records
    /// from the shard:
    ///
    /// * `AT_SEQUENCE_NUMBER` - Start reading exactly from the position denoted by
    ///   a
    /// specific sequence number.
    ///
    /// * `AFTER_SEQUENCE_NUMBER` - Start reading right after the position denoted
    ///   by a
    /// specific sequence number.
    ///
    /// * `TRIM_HORIZON` - Start reading at the last (untrimmed) stream record,
    ///   which is
    /// the oldest record in the shard. In DynamoDB Streams, there is a 24 hour
    /// limit on data retention.
    /// Stream records whose age exceeds this limit are subject to removal
    /// (trimming) from the
    /// stream.
    ///
    /// * `LATEST` - Start reading just after the most recent stream record in the
    /// shard, so that you always read the most recent data in the shard.
    shard_iterator_type: ShardIteratorType,

    /// The Amazon Resource Name (ARN) for the stream.
    stream_arn: []const u8,

    pub const json_field_names = .{
        .sequence_number = "SequenceNumber",
        .shard_id = "ShardId",
        .shard_iterator_type = "ShardIteratorType",
        .stream_arn = "StreamArn",
    };
};

pub const GetShardIteratorOutput = struct {
    /// The position in the shard from which to start reading stream records
    /// sequentially. A shard iterator specifies this position using the sequence
    /// number of a stream record in a shard.
    shard_iterator: ?[]const u8 = null,

    pub const json_field_names = .{
        .shard_iterator = "ShardIterator",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetShardIteratorInput, options: Options) !GetShardIteratorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "dynamodbstreams");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetShardIteratorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodbstreams", "DynamoDB Streams", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "DynamoDBStreams_20120810.GetShardIterator");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetShardIteratorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetShardIteratorOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ExpiredIteratorException")) {
        return .{ .arena = arena, .kind = .{ .expired_iterator_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrimmedDataAccessException")) {
        return .{ .arena = arena, .kind = .{ .trimmed_data_access_exception = .{
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
