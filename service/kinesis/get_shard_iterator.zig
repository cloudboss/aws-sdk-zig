const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ShardIteratorType = @import("shard_iterator_type.zig").ShardIteratorType;

pub const GetShardIteratorInput = struct {
    /// The shard ID of the Kinesis Data Streams shard to get the iterator for.
    shard_id: []const u8,

    /// Determines how the shard iterator is used to start reading data records from
    /// the
    /// shard.
    ///
    /// The following are the valid Amazon Kinesis shard iterator types:
    ///
    /// * AT_SEQUENCE_NUMBER - Start reading from the position denoted by a specific
    /// sequence number, provided in the value
    /// `StartingSequenceNumber`.
    ///
    /// * AFTER_SEQUENCE_NUMBER - Start reading right after the position denoted by
    ///   a
    /// specific sequence number, provided in the value
    /// `StartingSequenceNumber`.
    ///
    /// * AT_TIMESTAMP - Start reading from the position denoted by a specific time
    /// stamp, provided in the value `Timestamp`.
    ///
    /// * TRIM_HORIZON - Start reading at the last untrimmed record in the shard in
    ///   the
    /// system, which is the oldest data record in the shard.
    ///
    /// * LATEST - Start reading just after the most recent record in the shard, so
    ///   that
    /// you always read the most recent data in the shard.
    shard_iterator_type: ShardIteratorType,

    /// The sequence number of the data record in the shard from which to start
    /// reading. Used
    /// with shard iterator type AT_SEQUENCE_NUMBER and AFTER_SEQUENCE_NUMBER.
    starting_sequence_number: ?[]const u8 = null,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// The name of the Amazon Kinesis data stream.
    stream_name: ?[]const u8 = null,

    /// The time stamp of the data record from which to start reading. Used with
    /// shard
    /// iterator type AT_TIMESTAMP. A time stamp is the Unix epoch date with
    /// precision in
    /// milliseconds. For example, `2016-04-04T19:58:46.480-00:00` or
    /// `1459799926.480`. If a record with this exact time stamp does not exist,
    /// the iterator returned is for the next (later) record. If the time stamp is
    /// older than
    /// the current trim horizon, the iterator returned is for the oldest untrimmed
    /// data record
    /// (TRIM_HORIZON).
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .shard_id = "ShardId",
        .shard_iterator_type = "ShardIteratorType",
        .starting_sequence_number = "StartingSequenceNumber",
        .stream_arn = "StreamARN",
        .stream_id = "StreamId",
        .stream_name = "StreamName",
        .timestamp = "Timestamp",
    };
};

pub const GetShardIteratorOutput = struct {
    /// The position in the shard from which to start reading data records
    /// sequentially. A
    /// shard iterator specifies this position using the sequence number of a data
    /// record in a
    /// shard.
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kinesis");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetShardIteratorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesis", "Kinesis", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.GetShardIterator");

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
    if (std.mem.eql(u8, error_code, "ExpiredIteratorException")) {
        return .{ .arena = arena, .kind = .{ .expired_iterator_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .expired_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSOptInRequired")) {
        return .{ .arena = arena, .kind = .{ .kms_opt_in_required = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .kms_throttling_exception = .{
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
    if (std.mem.eql(u8, error_code, "ProvisionedThroughputExceededException")) {
        return .{ .arena = arena, .kind = .{ .provisioned_throughput_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
