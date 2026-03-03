const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const QueryLanguageVersion = @import("query_language_version.zig").QueryLanguageVersion;

const GetEngineStatusInput = struct {};

pub const GetEngineStatusOutput = struct {
    /// Set to the Neptune engine version running on your DB cluster. If this engine
    /// version has been manually patched since it was released, the version number
    /// is prefixed by `Patch-`.
    db_engine_version: ?[]const u8 = null,

    /// Set to `enabled` if the DFE engine is fully enabled, or to `viaQueryHint`
    /// (the default) if the DFE engine is only used with queries that have the
    /// `useDFE` query hint set to `true`.
    dfe_query_engine: ?[]const u8 = null,

    /// Contains status information about the features enabled on your DB cluster.
    features: ?[]const aws.map.StringMapEntry = null,

    /// Contains information about the Gremlin query language available on your
    /// cluster. Specifically, it contains a version field that specifies the
    /// current TinkerPop version being used by the engine.
    gremlin: ?QueryLanguageVersion = null,

    /// Contains Lab Mode settings being used by the engine.
    lab_mode: ?[]const aws.map.StringMapEntry = null,

    /// Contains information about the openCypher query language available on your
    /// cluster. Specifically, it contains a version field that specifies the
    /// current operCypher version being used by the engine.
    opencypher: ?QueryLanguageVersion = null,

    /// Set to `reader` if the instance is a read-replica, or to `writer` if the
    /// instance is the primary instance.
    role: ?[]const u8 = null,

    /// If there are transactions being rolled back, this field is set to the number
    /// of such transactions. If there are none, the field doesn't appear at all.
    rolling_back_trx_count: ?i32 = null,

    /// Set to the start time of the earliest transaction being rolled back. If no
    /// transactions are being rolled back, the field doesn't appear at all.
    rolling_back_trx_earliest_start_time: ?[]const u8 = null,

    /// Contains information about the current settings on your DB cluster. For
    /// example, contains the current cluster query timeout setting
    /// (`clusterQueryTimeoutInMs`).
    settings: ?[]const aws.map.StringMapEntry = null,

    /// Contains information about the SPARQL query language available on your
    /// cluster. Specifically, it contains a version field that specifies the
    /// current SPARQL version being used by the engine.
    sparql: ?QueryLanguageVersion = null,

    /// Set to the UTC time at which the current server process started.
    start_time: ?[]const u8 = null,

    /// Set to `healthy` if the instance is not experiencing problems. If the
    /// instance is recovering from a crash or from being rebooted and there are
    /// active transactions running from the latest server shutdown, status is set
    /// to `recovery`.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .db_engine_version = "dbEngineVersion",
        .dfe_query_engine = "dfeQueryEngine",
        .features = "features",
        .gremlin = "gremlin",
        .lab_mode = "labMode",
        .opencypher = "opencypher",
        .role = "role",
        .rolling_back_trx_count = "rollingBackTrxCount",
        .rolling_back_trx_earliest_start_time = "rollingBackTrxEarliestStartTime",
        .settings = "settings",
        .sparql = "sparql",
        .start_time = "startTime",
        .status = "status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEngineStatusInput, options: Options) !GetEngineStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "neptunedata");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEngineStatusInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("neptunedata", "neptunedata", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/status";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEngineStatusOutput {
    var result: GetEngineStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEngineStatusOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BulkLoadIdNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .bulk_load_id_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CancelledByUserException")) {
        return .{ .arena = arena, .kind = .{ .cancelled_by_user_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClientTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .client_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConstraintViolationException")) {
        return .{ .arena = arena, .kind = .{ .constraint_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredStreamException")) {
        return .{ .arena = arena, .kind = .{ .expired_stream_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FailureByQueryException")) {
        return .{ .arena = arena, .kind = .{ .failure_by_query_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalArgumentException")) {
        return .{ .arena = arena, .kind = .{ .illegal_argument_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidNumericDataException")) {
        return .{ .arena = arena, .kind = .{ .invalid_numeric_data_exception = .{
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
    if (std.mem.eql(u8, error_code, "LoadUrlAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .load_url_access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "MemoryLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .memory_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MethodNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .method_not_allowed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingParameterException")) {
        return .{ .arena = arena, .kind = .{ .missing_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MLResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ml_resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParsingException")) {
        return .{ .arena = arena, .kind = .{ .parsing_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionsFailedException")) {
        return .{ .arena = arena, .kind = .{ .preconditions_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .query_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryLimitException")) {
        return .{ .arena = arena, .kind = .{ .query_limit_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .query_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReadOnlyViolationException")) {
        return .{ .arena = arena, .kind = .{ .read_only_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3Exception")) {
        return .{ .arena = arena, .kind = .{ .s3_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerShutdownException")) {
        return .{ .arena = arena, .kind = .{ .server_shutdown_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StatisticsNotAvailableException")) {
        return .{ .arena = arena, .kind = .{ .statistics_not_available_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StreamRecordsNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .stream_records_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "TimeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .time_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
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
