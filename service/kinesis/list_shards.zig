const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ShardFilter = @import("shard_filter.zig").ShardFilter;
const Shard = @import("shard.zig").Shard;

pub const ListShardsInput = struct {
    /// Specify this parameter to indicate that you want to list the shards starting
    /// with the
    /// shard whose ID immediately follows `ExclusiveStartShardId`.
    ///
    /// If you don't specify this parameter, the default behavior is for
    /// `ListShards` to list the shards starting with the first one in the
    /// stream.
    ///
    /// You cannot specify this parameter if you specify `NextToken`.
    exclusive_start_shard_id: ?[]const u8 = null,

    /// The maximum number of shards to return in a single call to `ListShards`.
    /// The maximum number of shards to return in a single call. The default value
    /// is 1000. If
    /// you specify a value greater than 1000, at most 1000 results are returned.
    ///
    /// When the number of shards to be listed is greater than the value of
    /// `MaxResults`, the response contains a `NextToken` value that
    /// you can use in a subsequent call to `ListShards` to list the next set of
    /// shards.
    max_results: ?i32 = null,

    /// When the number of shards in the data stream is greater than the default
    /// value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of shards in the data stream,
    /// the response includes a pagination token named `NextToken`. You can specify
    /// this `NextToken` value in a subsequent call to `ListShards` to
    /// list the next set of shards.
    ///
    /// Don't specify `StreamName` or `StreamCreationTimestamp` if you
    /// specify `NextToken` because the latter unambiguously identifies the
    /// stream.
    ///
    /// You can optionally specify a value for the `MaxResults` parameter when you
    /// specify `NextToken`. If you specify a `MaxResults` value that is
    /// less than the number of shards that the operation returns if you don't
    /// specify
    /// `MaxResults`, the response will contain a new `NextToken`
    /// value. You can use the new `NextToken` value in a subsequent call to the
    /// `ListShards` operation.
    ///
    /// Tokens expire after 300 seconds. When you obtain a value for
    /// `NextToken` in the response to a call to `ListShards`, you
    /// have 300 seconds to use that value. If you specify an expired token in a
    /// call to
    /// `ListShards`, you get `ExpiredNextTokenException`.
    next_token: ?[]const u8 = null,

    /// Enables you to filter out the response of the `ListShards` API. You can
    /// only specify one filter at a time.
    ///
    /// If you use the `ShardFilter` parameter when invoking the ListShards API,
    /// the `Type` is the required property and must be specified. If you specify
    /// the
    /// `AT_TRIM_HORIZON`, `FROM_TRIM_HORIZON`, or
    /// `AT_LATEST` types, you do not need to specify either the
    /// `ShardId` or the `Timestamp` optional properties.
    ///
    /// If you specify the `AFTER_SHARD_ID` type, you must also provide the value
    /// for the optional `ShardId` property. The `ShardId` property is
    /// identical in fuctionality to the `ExclusiveStartShardId` parameter of the
    /// `ListShards` API. When `ShardId` property is specified, the
    /// response includes the shards starting with the shard whose ID immediately
    /// follows the
    /// `ShardId` that you provided.
    ///
    /// If you specify the `AT_TIMESTAMP` or `FROM_TIMESTAMP_ID` type,
    /// you must also provide the value for the optional `Timestamp` property. If
    /// you
    /// specify the AT_TIMESTAMP type, then all shards that were open at the
    /// provided timestamp
    /// are returned. If you specify the FROM_TIMESTAMP type, then all shards
    /// starting from the
    /// provided timestamp to TIP are returned.
    shard_filter: ?ShardFilter = null,

    /// The ARN of the stream.
    stream_arn: ?[]const u8 = null,

    /// Specify this input parameter to distinguish data streams that have the same
    /// name. For
    /// example, if you create a data stream and then delete it, and you later
    /// create another
    /// data stream with the same name, you can use this input parameter to specify
    /// which of the
    /// two streams you want to list the shards for.
    ///
    /// You cannot specify this parameter if you specify the `NextToken`
    /// parameter.
    stream_creation_timestamp: ?i64 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// The name of the data stream whose shards you want to list.
    ///
    /// You cannot specify this parameter if you specify the `NextToken`
    /// parameter.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .exclusive_start_shard_id = "ExclusiveStartShardId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .shard_filter = "ShardFilter",
        .stream_arn = "StreamARN",
        .stream_creation_timestamp = "StreamCreationTimestamp",
        .stream_id = "StreamId",
        .stream_name = "StreamName",
    };
};

pub const ListShardsOutput = struct {
    /// When the number of shards in the data stream is greater than the default
    /// value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of shards in the data stream,
    /// the response includes a pagination token named `NextToken`. You can specify
    /// this `NextToken` value in a subsequent call to `ListShards` to
    /// list the next set of shards. For more information about the use of this
    /// pagination token
    /// when calling the `ListShards` operation, see ListShardsInput$NextToken.
    ///
    /// Tokens expire after 300 seconds. When you obtain a value for
    /// `NextToken` in the response to a call to `ListShards`, you
    /// have 300 seconds to use that value. If you specify an expired token in a
    /// call to
    /// `ListShards`, you get `ExpiredNextTokenException`.
    next_token: ?[]const u8 = null,

    /// An array of JSON objects. Each object represents one shard and specifies the
    /// IDs of
    /// the shard, the shard's parent, and the shard that's adjacent to the shard's
    /// parent. Each
    /// object also contains the starting and ending hash keys and the starting and
    /// ending
    /// sequence numbers for the shard.
    shards: ?[]const Shard = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .shards = "Shards",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListShardsInput, options: Options) !ListShardsOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ListShardsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesis", "Kinesis", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "Kinesis_20131202.ListShards");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListShardsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListShardsOutput, body, alloc);
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
