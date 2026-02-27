const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "keyspacesstreams");

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
    const endpoint = try config.getEndpointForService("keyspacesstreams", "KeyspacesStreams", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "KeyspacesStreams.GetShardIterator");

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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
