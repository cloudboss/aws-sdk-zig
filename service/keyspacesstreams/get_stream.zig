const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ShardFilter = @import("shard_filter.zig").ShardFilter;
const Shard = @import("shard.zig").Shard;
const StreamStatus = @import("stream_status.zig").StreamStatus;
const StreamViewType = @import("stream_view_type.zig").StreamViewType;

pub const GetStreamInput = struct {
    /// The maximum number of shard objects to return in a single `GetStream`
    /// request. Default value is 100. The minimum value is 1 and the maximum value
    /// is 100.
    max_results: ?i32 = null,

    /// An optional pagination token provided by a previous `GetStream` operation.
    /// If this parameter is specified, the response includes only records beyond
    /// the token, up to the value specified by `maxResults`.
    next_token: ?[]const u8 = null,

    /// Optional filter criteria to apply when retrieving shards. You can filter
    /// shards based on their state or other attributes to narrow down the results
    /// returned by the `GetStream` operation.
    shard_filter: ?ShardFilter = null,

    /// The Amazon Resource Name (ARN) of the stream for which detailed information
    /// is requested. This uniquely identifies the specific stream you want to get
    /// information about.
    stream_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .shard_filter = "shardFilter",
        .stream_arn = "streamArn",
    };
};

pub const GetStreamOutput = struct {
    /// The date and time when the request to create this stream was issued. The
    /// value is represented in ISO 8601 format.
    creation_request_date_time: i64,

    /// The name of the keyspace containing the table associated with this stream.
    /// The keyspace name is part of the table's hierarchical identifier in Amazon
    /// Keyspaces.
    keyspace_name: []const u8,

    /// A pagination token that can be used in a subsequent `GetStream` request.
    /// This token is returned if the response contains more shards than can be
    /// returned in a single response.
    next_token: ?[]const u8 = null,

    /// An array of shard objects associated with this stream. Each shard contains a
    /// subset of the stream's data records and has its own unique identifier. The
    /// collection of shards represents the complete stream data.
    shards: ?[]const Shard = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the stream within
    /// Amazon Keyspaces. This ARN can be used in other API operations to reference
    /// this specific stream.
    stream_arn: []const u8,

    /// A timestamp that serves as a unique identifier for this stream, used for
    /// debugging and monitoring purposes. The stream label represents the point in
    /// time when the stream was created.
    stream_label: []const u8,

    /// The current status of the stream. Values can be `ENABLING`, `ENABLED`,
    /// `DISABLING`, or `DISABLED`. Operations on the stream depend on its current
    /// status.
    stream_status: StreamStatus,

    /// The format of the data records in this stream. Currently, this can be one of
    /// the following options:
    ///
    /// * `NEW_AND_OLD_IMAGES` - both versions of the row, before and after the
    ///   change. This is the default.
    /// * `NEW_IMAGE` - the version of the row after the change.
    /// * `OLD_IMAGE` - the version of the row before the change.
    /// * `KEYS_ONLY` - the partition and clustering keys of the row that was
    ///   changed.
    stream_view_type: StreamViewType,

    /// The name of the table associated with this stream. The stream captures
    /// changes to rows in this Amazon Keyspaces table.
    table_name: []const u8,

    pub const json_field_names = .{
        .creation_request_date_time = "creationRequestDateTime",
        .keyspace_name = "keyspaceName",
        .next_token = "nextToken",
        .shards = "shards",
        .stream_arn = "streamArn",
        .stream_label = "streamLabel",
        .stream_status = "streamStatus",
        .stream_view_type = "streamViewType",
        .table_name = "tableName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStreamInput, options: CallOptions) !GetStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cassandra");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cassandra-streams", "KeyspacesStreams", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "KeyspacesStreams.GetStream");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStreamOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetStreamOutput, body, allocator);
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
