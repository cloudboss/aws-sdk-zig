const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RestApiMethod = @import("rest_api_method.zig").RestApiMethod;

pub const InvokeRestApiInput = struct {
    /// The request body for the Apache Airflow REST API call, provided as a JSON
    /// object.
    body: ?[]const u8 = null,

    /// The HTTP method used for making Airflow REST API calls. For example, `POST`.
    method: RestApiMethod,

    /// The name of the Amazon MWAA environment. For example, `MyMWAAEnvironment`.
    name: []const u8,

    /// The Apache Airflow REST API endpoint path to be called. For example,
    /// `/dags/123456/clearTaskInstances`. For more information, see [Apache Airflow
    /// API](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html)
    path: []const u8,

    /// Query parameters to be included in the Apache Airflow REST API call,
    /// provided as a JSON object.
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "airflow", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeRestApiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("airflow", "MWAA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapi/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
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
