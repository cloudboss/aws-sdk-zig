const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FilteredLogEvent = @import("filtered_log_event.zig").FilteredLogEvent;
const SearchedLogStream = @import("searched_log_stream.zig").SearchedLogStream;

pub const FilterLogEventsInput = struct {
    /// The end of the time range, expressed as the number of milliseconds after
    /// `Jan 1,
    /// 1970 00:00:00 UTC`. Events with a timestamp later than this time are not
    /// returned.
    end_time: ?i64 = null,

    /// The filter pattern to use. For more information, see [Filter and Pattern
    /// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html).
    ///
    /// If not provided, all the events are matched.
    filter_pattern: ?[]const u8 = null,

    /// If the value is true, the operation attempts to provide responses that
    /// contain events
    /// from multiple log streams within the log group, interleaved in a single
    /// response. If the value
    /// is false, all the matched log events in the first log stream are searched
    /// first, then those in
    /// the next log stream, and so on.
    ///
    /// **Important** As of June 17, 2019, this parameter is
    /// ignored and the value is assumed to be true. The response from this
    /// operation always
    /// interleaves events from multiple log streams within a log group.
    interleaved: ?bool = null,

    /// The maximum number of events to return. The default is 10,000 events.
    limit: ?i32 = null,

    /// Specify either the name or ARN of the log group to view log events from. If
    /// the log group
    /// is in a source account and you are using a monitoring account, you must use
    /// the log group
    /// ARN.
    ///
    /// You must include either `logGroupIdentifier` or `logGroupName`,
    /// but not both.
    log_group_identifier: ?[]const u8 = null,

    /// The name of the log group to search.
    ///
    /// You must include either `logGroupIdentifier` or `logGroupName`,
    /// but not both.
    log_group_name: ?[]const u8 = null,

    /// Filters the results to include only events from log streams that have names
    /// starting with
    /// this prefix.
    ///
    /// If you specify a value for both `logStreamNamePrefix` and
    /// `logStreamNames`, the action returns an `InvalidParameterException`
    /// error.
    log_stream_name_prefix: ?[]const u8 = null,

    /// Filters the results to only logs from the log streams in this list.
    ///
    /// If you specify a value for both `logStreamNames` and
    /// `logStreamNamePrefix`, the action returns an
    /// `InvalidParameterException` error.
    log_stream_names: ?[]const []const u8 = null,

    /// The token for the next set of events to return. (You received this token
    /// from a
    /// previous call.)
    next_token: ?[]const u8 = null,

    /// The start of the time range, expressed as the number of milliseconds after
    /// `Jan 1,
    /// 1970 00:00:00 UTC`. Events with a timestamp before this time are not
    /// returned.
    start_time: ?i64 = null,

    /// Specify `true` to display the log event fields with all sensitive data
    /// unmasked
    /// and visible. The default is `false`.
    ///
    /// To use this operation with this parameter, you must be signed into an
    /// account with the
    /// `logs:Unmask` permission.
    unmask: ?bool = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .filter_pattern = "filterPattern",
        .interleaved = "interleaved",
        .limit = "limit",
        .log_group_identifier = "logGroupIdentifier",
        .log_group_name = "logGroupName",
        .log_stream_name_prefix = "logStreamNamePrefix",
        .log_stream_names = "logStreamNames",
        .next_token = "nextToken",
        .start_time = "startTime",
        .unmask = "unmask",
    };
};

pub const FilterLogEventsOutput = struct {
    /// The matched events.
    events: ?[]const FilteredLogEvent = null,

    /// The token to use when requesting the next set of items. The token expires
    /// after 24
    /// hours.
    ///
    /// If the results don't include a `nextToken`, then pagination is finished.
    next_token: ?[]const u8 = null,

    /// **Important** As of May 15, 2020, this parameter is no longer
    /// supported. This parameter returns an empty list.
    ///
    /// Indicates which log streams have been searched and whether each has been
    /// searched
    /// completely.
    searched_log_streams: ?[]const SearchedLogStream = null,

    pub const json_field_names = .{
        .events = "events",
        .next_token = "nextToken",
        .searched_log_streams = "searchedLogStreams",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: FilterLogEventsInput, options: CallOptions) !FilterLogEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudwatchlogs");

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

fn serializeRequest(allocator: std.mem.Allocator, input: FilterLogEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatchlogs", "CloudWatch Logs", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.FilterLogEvents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !FilterLogEventsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(FilterLogEventsOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DataAlreadyAcceptedException")) {
        return .{ .arena = arena, .kind = .{ .data_already_accepted_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSequenceTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sequence_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "MalformedQueryException")) {
        return .{ .arena = arena, .kind = .{ .malformed_query_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationAbortedException")) {
        return .{ .arena = arena, .kind = .{ .operation_aborted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnrecognizedClientException")) {
        return .{ .arena = arena, .kind = .{ .unrecognized_client_exception = .{
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
