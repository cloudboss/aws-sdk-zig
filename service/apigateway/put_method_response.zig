const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutMethodResponseInput = struct {
    /// The HTTP verb of the Method resource.
    http_method: []const u8,

    /// The Resource identifier for the Method resource.
    resource_id: []const u8,

    /// Specifies the Model resources used for the response's content type. Response
    /// models are represented as a key/value map, with a content type as the key
    /// and a Model name as the value.
    response_models: ?[]const aws.map.StringMapEntry = null,

    /// A key-value map specifying required or optional response parameters that API
    /// Gateway can send back to the caller. A key defines a method response header
    /// name and the associated value is a Boolean flag indicating whether the
    /// method response parameter is required or not. The method response header
    /// names must match the pattern of `method.response.header.{name}`, where
    /// `name` is a valid and unique header name. The response parameter names
    /// defined here are available in the integration response to be mapped from an
    /// integration response header expressed in
    /// `integration.response.header.{name}`, a static value enclosed within a pair
    /// of single quotes (e.g., `'application/json'`), or a JSON expression from the
    /// back-end response payload in the form of
    /// `integration.response.body.{JSON-expression}`, where `JSON-expression` is a
    /// valid JSON expression without the `$` prefix.)
    response_parameters: ?[]const aws.map.MapEntry(bool) = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// The method response's status code.
    status_code: []const u8,

    pub const json_field_names = .{
        .http_method = "httpMethod",
        .resource_id = "resourceId",
        .response_models = "responseModels",
        .response_parameters = "responseParameters",
        .rest_api_id = "restApiId",
        .status_code = "statusCode",
    };
};

pub const PutMethodResponseOutput = @import("method_response.zig").MethodResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutMethodResponseInput, options: CallOptions) !PutMethodResponseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutMethodResponseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/resources/");
    try path_buf.appendSlice(allocator, input.resource_id);
    try path_buf.appendSlice(allocator, "/methods/");
    try path_buf.appendSlice(allocator, input.http_method);
    try path_buf.appendSlice(allocator, "/responses/");
    try path_buf.appendSlice(allocator, input.status_code);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.response_models) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"responseModels\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.response_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"responseParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutMethodResponseOutput {
    const result: PutMethodResponseOutput = try aws.json.parseJsonObject(
        PutMethodResponseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
