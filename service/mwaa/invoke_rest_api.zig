const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RestApiMethod = @import("rest_api_method.zig").RestApiMethod;

pub const InvokeRestApiInput = struct {
    /// The request body for the Apache Airflow REST API call, provided as a JSON
    /// object.
    body: ?[]const u8 = null,

    /// The HTTP method used for making Airflow REST API calls. For example,
    /// `POST`.
    method: RestApiMethod,

    /// The name of the Amazon MWAA environment. For example, `MyMWAAEnvironment`.
    name: []const u8,

    /// The Apache Airflow REST API endpoint path to be called. For example,
    /// `/dags/123456/clearTaskInstances`. For more information, see [Apache Airflow
    /// API](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html)
    path: []const u8,

    /// Query parameters to be included in the Apache Airflow REST API call,
    /// provided as a
    /// JSON object.
    query_parameters: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .method = "Method",
        .name = "Name",
        .path = "Path",
        .query_parameters = "QueryParameters",
    };
};

pub const InvokeRestApiOutput = struct {
    /// The response data from the Apache Airflow REST API call, provided as a JSON
    /// object.
    rest_api_response: ?[]const u8 = null,

    /// The HTTP status code returned by the Apache Airflow REST API call.
    rest_api_status_code: ?i32 = null,

    pub const json_field_names = .{
        .rest_api_response = "RestApiResponse",
        .rest_api_status_code = "RestApiStatusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeRestApiInput, options: CallOptions) !InvokeRestApiOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "airflow");

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

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeRestApiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("airflow", "MWAA", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/restapi/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.body) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Body\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Method\":");
    try aws.json.writeValue(@TypeOf(input.method), input.method, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Path\":");
    try aws.json.writeValue(@TypeOf(input.path), input.path, allocator, &body_buf);
    has_prev = true;
    if (input.query_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueryParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InvokeRestApiOutput {
    var result: InvokeRestApiOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(InvokeRestApiOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "RestApiClientException")) {
        return .{ .arena = arena, .kind = .{ .rest_api_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RestApiServerException")) {
        return .{ .arena = arena, .kind = .{ .rest_api_server_exception = .{
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
