const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContentHandlingStrategy = @import("content_handling_strategy.zig").ContentHandlingStrategy;

pub const GetIntegrationResponseInput = struct {
    /// The API identifier.
    api_id: []const u8,

    /// The integration ID.
    integration_id: []const u8,

    /// The integration response ID.
    integration_response_id: []const u8,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .integration_id = "IntegrationId",
        .integration_response_id = "IntegrationResponseId",
    };
};

pub const GetIntegrationResponseOutput = struct {
    /// Supported only for WebSocket APIs. Specifies how to handle response payload
    /// content type conversions. Supported values are CONVERT_TO_BINARY and
    /// CONVERT_TO_TEXT, with the following behaviors:
    ///
    /// CONVERT_TO_BINARY: Converts a response payload from a Base64-encoded string
    /// to the corresponding binary blob.
    ///
    /// CONVERT_TO_TEXT: Converts a response payload from a binary blob to a
    /// Base64-encoded string.
    ///
    /// If this property is not defined, the response payload will be passed through
    /// from the integration response to the route response or method response
    /// without modification.
    content_handling_strategy: ?ContentHandlingStrategy = null,

    /// The integration response ID.
    integration_response_id: ?[]const u8 = null,

    /// The integration response key.
    integration_response_key: ?[]const u8 = null,

    /// A key-value map specifying response parameters that are passed to the method
    /// response from the backend. The key is a method response header parameter
    /// name and the mapped value is an integration response header value, a static
    /// value enclosed within a pair of single quotes, or a JSON expression from the
    /// integration response body. The mapping key must match the pattern of
    /// method.response.header.{name}, where name is a valid and unique header name.
    /// The mapped non-static value must match the pattern of
    /// integration.response.header.{name} or
    /// integration.response.body.{JSON-expression}, where name is a valid and
    /// unique response header name and JSON-expression is a valid JSON expression
    /// without the $ prefix.
    response_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The collection of response templates for the integration response as a
    /// string-to-string map of key-value pairs. Response templates are represented
    /// as a key/value map, with a content-type as the key and a template as the
    /// value.
    response_templates: ?[]const aws.map.StringMapEntry = null,

    /// The template selection expressions for the integration response.
    template_selection_expression: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_handling_strategy = "ContentHandlingStrategy",
        .integration_response_id = "IntegrationResponseId",
        .integration_response_key = "IntegrationResponseKey",
        .response_parameters = "ResponseParameters",
        .response_templates = "ResponseTemplates",
        .template_selection_expression = "TemplateSelectionExpression",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIntegrationResponseInput, options: CallOptions) !GetIntegrationResponseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIntegrationResponseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/integrations/");
    try path_buf.appendSlice(allocator, input.integration_id);
    try path_buf.appendSlice(allocator, "/integrationresponses/");
    try path_buf.appendSlice(allocator, input.integration_response_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIntegrationResponseOutput {
    const result: GetIntegrationResponseOutput = try aws.json.parseJsonObject(
        GetIntegrationResponseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
