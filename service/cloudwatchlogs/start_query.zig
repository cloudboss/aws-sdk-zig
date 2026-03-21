const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const QueryLanguage = @import("query_language.zig").QueryLanguage;

pub const StartQueryInput = struct {
    /// The end of the time range to query. The range is inclusive, so the specified
    /// end time is
    /// included in the query. Specified as epoch time, the number of seconds since
    /// `January 1,
    /// 1970, 00:00:00 UTC`.
    end_time: i64,

    /// The maximum number of log events to return in the query. If the query string
    /// uses the
    /// `fields` command, only the specified fields and their values are returned.
    /// The
    /// default is 10,000.
    limit: ?i32 = null,

    /// The list of log groups to query. You can include up to 50 log groups.
    ///
    /// You can specify them by the log group name or ARN. If a log group that
    /// you're querying is
    /// in a source account and you're using a monitoring account, you must specify
    /// the ARN of the log
    /// group here. The query definition must also be defined in the monitoring
    /// account.
    ///
    /// If you specify an ARN, use the format
    /// arn:aws:logs:*region*:*account-id*:log-group:*log_group_name*
    /// Don't include an * at the end.
    ///
    /// A `StartQuery` operation must include exactly one of the following
    /// parameters:
    /// `logGroupName`, `logGroupNames`, or `logGroupIdentifiers`.
    /// The exception is queries using the OpenSearch Service SQL query language,
    /// where you specify
    /// the log group names inside the `querystring` instead of here.
    log_group_identifiers: ?[]const []const u8 = null,

    /// The log group on which to perform the query.
    ///
    /// A `StartQuery` operation must include exactly one of the following
    /// parameters: `logGroupName`, `logGroupNames`, or
    /// `logGroupIdentifiers`. The exception is queries using the OpenSearch Service
    /// SQL query language, where you specify the log group names inside the
    /// `querystring` instead of here.
    log_group_name: ?[]const u8 = null,

    /// The list of log groups to be queried. You can include up to 50 log groups.
    ///
    /// A `StartQuery` operation must include exactly one of the following
    /// parameters: `logGroupName`, `logGroupNames`, or
    /// `logGroupIdentifiers`. The exception is queries using the OpenSearch Service
    /// SQL query language, where you specify the log group names inside the
    /// `querystring` instead of here.
    log_group_names: ?[]const []const u8 = null,

    /// Specify the query language to use for this query. The options are Logs
    /// Insights QL,
    /// OpenSearch PPL, and OpenSearch SQL. For more information about the query
    /// languages that
    /// CloudWatch Logs supports, see [Supported query
    /// languages](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_AnalyzeLogData_Languages.html).
    query_language: ?QueryLanguage = null,

    /// The query string to use. For more information, see [CloudWatch Logs Insights
    /// Query
    /// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html).
    query_string: []const u8,

    /// The beginning of the time range to query. The range is inclusive, so the
    /// specified start
    /// time is included in the query. Specified as epoch time, the number of
    /// seconds since
    /// `January 1, 1970, 00:00:00 UTC`.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .limit = "limit",
        .log_group_identifiers = "logGroupIdentifiers",
        .log_group_name = "logGroupName",
        .log_group_names = "logGroupNames",
        .query_language = "queryLanguage",
        .query_string = "queryString",
        .start_time = "startTime",
    };
};

pub const StartQueryOutput = struct {
    /// The unique ID of the query.
    query_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .query_id = "queryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartQueryInput, options: CallOptions) !StartQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "logs");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.StartQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartQueryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartQueryOutput, body, allocator);
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
