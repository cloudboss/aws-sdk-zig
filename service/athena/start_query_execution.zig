const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EngineConfiguration = @import("engine_configuration.zig").EngineConfiguration;
const QueryExecutionContext = @import("query_execution_context.zig").QueryExecutionContext;
const ResultConfiguration = @import("result_configuration.zig").ResultConfiguration;
const ResultReuseConfiguration = @import("result_reuse_configuration.zig").ResultReuseConfiguration;

pub const StartQueryExecutionInput = struct {
    /// A unique case-sensitive string used to ensure the request to create the
    /// query is
    /// idempotent (executes only once). If another `StartQueryExecution` request is
    /// received, the same response is returned and another query is not created. An
    /// error is
    /// returned if a parameter, such as `QueryString`, has changed. A call to
    /// `StartQueryExecution` that uses a previous client request token returns
    /// the same `QueryExecutionId` even if the requester doesn't have permission on
    /// the tables specified in `QueryString`.
    ///
    /// This token is listed as not required because Amazon Web Services SDKs (for
    /// example
    /// the Amazon Web Services SDK for Java) auto-generate the token for users. If
    /// you are
    /// not using the Amazon Web Services SDK or the Amazon Web Services CLI, you
    /// must provide
    /// this token or the action will fail.
    client_request_token: ?[]const u8 = null,

    /// The engine configuration for the workgroup, which includes the
    /// minimum/maximum number of Data Processing Units (DPU) that queries should
    /// use when
    /// running in provisioned capacity. If not specified, Athena uses default
    /// values (Default value for min is 4 and for max is Minimum of 124 and
    /// allocated DPUs).
    ///
    /// To specify minimum and maximum DPU values for Capacity Reservations queries,
    /// the workgroup containing `EngineConfiguration` should have the following
    /// values: The name of
    /// the `Classifications` should be `athena-query-engine-properties`, with the
    /// only allowed properties as `max-dpu-count` and `min-dpu-count`.
    engine_configuration: ?EngineConfiguration = null,

    /// A list of values for the parameters in a query. The values are applied
    /// sequentially to
    /// the parameters in the query in the order in which the parameters occur.
    execution_parameters: ?[]const []const u8 = null,

    /// The database within which the query executes.
    query_execution_context: ?QueryExecutionContext = null,

    /// The SQL query statements to be executed.
    query_string: []const u8,

    /// Specifies information about where and how to save the results of the query
    /// execution.
    /// If the query runs in a workgroup, then workgroup's settings may override
    /// query settings.
    /// This affects the query results location. The workgroup settings override is
    /// specified in
    /// EnforceWorkGroupConfiguration (true/false) in the WorkGroupConfiguration.
    /// See WorkGroupConfiguration$EnforceWorkGroupConfiguration.
    result_configuration: ?ResultConfiguration = null,

    /// Specifies the query result reuse behavior for the query.
    result_reuse_configuration: ?ResultReuseConfiguration = null,

    /// The name of the workgroup in which the query is being started.
    work_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .engine_configuration = "EngineConfiguration",
        .execution_parameters = "ExecutionParameters",
        .query_execution_context = "QueryExecutionContext",
        .query_string = "QueryString",
        .result_configuration = "ResultConfiguration",
        .result_reuse_configuration = "ResultReuseConfiguration",
        .work_group = "WorkGroup",
    };
};

pub const StartQueryExecutionOutput = struct {
    /// The unique ID of the query that ran as a result of this request.
    query_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .query_execution_id = "QueryExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartQueryExecutionInput, options: CallOptions) !StartQueryExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "athena");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartQueryExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.StartQueryExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartQueryExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartQueryExecutionOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MetadataException")) {
        return .{ .arena = arena, .kind = .{ .metadata_exception = .{
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
    if (std.mem.eql(u8, error_code, "SessionAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .session_already_exists_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
