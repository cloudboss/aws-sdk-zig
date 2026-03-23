const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Consumer = @import("consumer.zig").Consumer;

pub const ListStreamConsumersInput = struct {
    /// The maximum number of consumers that you want a single call of
    /// `ListStreamConsumers` to return. The default value is 100. If you specify
    /// a value greater than 100, at most 100 results are returned.
    max_results: ?i32 = null,

    /// When the number of consumers that are registered with the data stream is
    /// greater than
    /// the default value for the `MaxResults` parameter, or if you explicitly
    /// specify a value for `MaxResults` that is less than the number of consumers
    /// that are registered with the data stream, the response includes a pagination
    /// token named
    /// `NextToken`. You can specify this `NextToken` value in a
    /// subsequent call to `ListStreamConsumers` to list the next set of registered
    /// consumers.
    ///
    /// Don't specify `StreamName` or `StreamCreationTimestamp` if you
    /// specify `NextToken` because the latter unambiguously identifies the
    /// stream.
    ///
    /// You can optionally specify a value for the `MaxResults` parameter when you
    /// specify `NextToken`. If you specify a `MaxResults` value that is
    /// less than the number of consumers that the operation returns if you don't
    /// specify
    /// `MaxResults`, the response will contain a new `NextToken`
    /// value. You can use the new `NextToken` value in a subsequent call to the
    /// `ListStreamConsumers` operation to list the next set of consumers.
    ///
    /// Tokens expire after 300 seconds. When you obtain a value for
    /// `NextToken` in the response to a call to
    /// `ListStreamConsumers`, you have 300 seconds to use that value. If you
    /// specify an expired token in a call to `ListStreamConsumers`, you get
    /// `ExpiredNextTokenException`.
    next_token: ?[]const u8 = null,

    /// The ARN of the Kinesis data stream for which you want to list the registered
    /// consumers. For more information, see [Amazon Resource Names (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kinesis-streams).
    stream_arn: []const u8,

    /// Specify this input parameter to distinguish data streams that have the same
    /// name. For
    /// example, if you create a data stream and then delete it, and you later
    /// create another
    /// data stream with the same name, you can use this input parameter to specify
    /// which of the
    /// two streams you want to list the consumers for.
    ///
    /// You can't specify this parameter if you specify the NextToken parameter.
    stream_creation_timestamp: ?i64 = null,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .stream_arn = "StreamARN",
        .stream_creation_timestamp = "StreamCreationTimestamp",
        .stream_id = "StreamId",
    };
};

pub const ListStreamConsumersOutput = struct {
    /// An array of JSON objects. Each object represents one registered consumer.
    consumers: ?[]const Consumer = null,

    /// When the number of consumers that are registered with the data stream is
    /// greater than
    /// the default value for the `MaxResults` parameter, or if you explicitly
    /// specify a value for `MaxResults` that is less than the number of registered
    /// consumers, the response includes a pagination token named `NextToken`. You
    /// can specify this `NextToken` value in a subsequent call to
    /// `ListStreamConsumers` to list the next set of registered consumers. For
    /// more information about the use of this pagination token when calling the
    /// `ListStreamConsumers` operation, see ListStreamConsumersInput$NextToken.
    ///
    /// Tokens expire after 300 seconds. When you obtain a value for
    /// `NextToken` in the response to a call to
    /// `ListStreamConsumers`, you have 300 seconds to use that value. If you
    /// specify an expired token in a call to `ListStreamConsumers`, you get
    /// `ExpiredNextTokenException`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .consumers = "Consumers",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStreamConsumersInput, options: CallOptions) !ListStreamConsumersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStreamConsumersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.ListStreamConsumers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStreamConsumersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListStreamConsumersOutput, body, allocator);
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
