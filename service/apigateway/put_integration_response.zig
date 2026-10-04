const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContentHandlingStrategy = @import("content_handling_strategy.zig").ContentHandlingStrategy;

pub const PutIntegrationResponseInput = struct {
    /// Specifies how to handle response payload content type conversions. Supported
    /// values are `CONVERT_TO_BINARY` and `CONVERT_TO_TEXT`, with the following
    /// behaviors:
    ///
    /// If this property is not defined, the response payload will be passed through
    /// from the integration response to the method response without modification.
    content_handling: ?ContentHandlingStrategy = null,

    /// Specifies a put integration response request's HTTP method.
    http_method: []const u8,

    /// Specifies a put integration response request's resource identifier.
    resource_id: []const u8,

    /// A key-value map specifying response parameters that are passed to the method
    /// response from the back end.
    /// The key is a method response header parameter name and the mapped value is
    /// an integration response header value, a static value enclosed within a pair
    /// of single quotes, or a JSON expression from the integration response body.
    /// The mapping key must match the pattern of `method.response.header.{name}`,
    /// where `name` is a valid and unique header name. The mapped non-static value
    /// must match the pattern of `integration.response.header.{name}` or
    /// `integration.response.body.{JSON-expression}`, where `name` must be a valid
    /// and unique response header name and `JSON-expression` a valid JSON
    /// expression without the `$` prefix.
    response_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Specifies a put integration response's templates.
    response_templates: ?[]const aws.map.StringMapEntry = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// Specifies the selection pattern of a put integration response.
    selection_pattern: ?[]const u8 = null,

    /// Specifies the status code that is used to map the integration response to an
    /// existing MethodResponse.
    status_code: []const u8,

    pub const json_field_names = .{
        .content_handling = "contentHandling",
        .http_method = "httpMethod",
        .resource_id = "resourceId",
        .response_parameters = "responseParameters",
        .response_templates = "responseTemplates",
        .rest_api_id = "restApiId",
        .selection_pattern = "selectionPattern",
        .status_code = "statusCode",
    };
};

pub const PutIntegrationResponseOutput = @import("integration_response.zig").IntegrationResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutIntegrationResponseInput, options: CallOptions) !PutIntegrationResponseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutIntegrationResponseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/resources/");
    try path_buf.appendSlice(allocator, input.resource_id);
    try path_buf.appendSlice(allocator, "/methods/");
    try path_buf.appendSlice(allocator, input.http_method);
    try path_buf.appendSlice(allocator, "/integration/responses/");
    try path_buf.appendSlice(allocator, input.status_code);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.content_handling) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contentHandling\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.response_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"responseParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.response_templates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"responseTemplates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.selection_pattern) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"selectionPattern\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutIntegrationResponseOutput {
    var result: PutIntegrationResponseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutIntegrationResponseOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
