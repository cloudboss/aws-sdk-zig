const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ShardFilter = @import("shard_filter.zig").ShardFilter;
const StreamDescription = @import("stream_description.zig").StreamDescription;

pub const DescribeStreamInput = struct {
    /// The shard ID of the first item that this operation will evaluate. Use the
    /// value that was
    /// returned for `LastEvaluatedShardId` in the previous operation.
    exclusive_start_shard_id: ?[]const u8 = null,

    /// The maximum number of shard objects to return. The upper limit is 100.
    limit: ?i32 = null,

    /// This optional field contains the filter definition for the
    /// `DescribeStream` API.
    shard_filter: ?ShardFilter = null,

    /// The Amazon Resource Name (ARN) for the stream.
    stream_arn: []const u8,

    pub const json_field_names = .{
        .exclusive_start_shard_id = "ExclusiveStartShardId",
        .limit = "Limit",
        .shard_filter = "ShardFilter",
        .stream_arn = "StreamArn",
    };
};

pub const DescribeStreamOutput = struct {
    /// A complete description of the stream, including its creation date and time,
    /// the DynamoDB table associated with the stream, the shard IDs within the
    /// stream, and the beginning and ending sequence numbers of stream records
    /// within the shards.
    stream_description: ?StreamDescription = null,

    pub const json_field_names = .{
        .stream_description = "StreamDescription",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStreamInput, options: Options) !DescribeStreamOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodbstreams", "DynamoDB Streams", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDBStreams_20120810.DescribeStream");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStreamOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeStreamOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
