const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetShardIteratorInput, options: CallOptions) !GetShardIteratorOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetShardIteratorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("streams.dynamodb", "DynamoDB Streams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDBStreams_20120810.GetShardIterator");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetShardIteratorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetShardIteratorOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.ExpiredIteratorException = aws.json.parseJsonObject(errors.ExpiredIteratorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .expired_iterator_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        const parsed_error: ?errors.InternalServerError = aws.json.parseJsonObject(errors.InternalServerError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TrimmedDataAccessException")) {
        const parsed_error: ?errors.TrimmedDataAccessException = aws.json.parseJsonObject(errors.TrimmedDataAccessException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .trimmed_data_access_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
