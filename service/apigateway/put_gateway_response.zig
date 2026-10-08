const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GatewayResponseType = @import("gateway_response_type.zig").GatewayResponseType;

pub const PutGatewayResponseInput = struct {
    /// Response parameters (paths, query strings and headers) of the
    /// GatewayResponse as a string-to-string map of key-value pairs.
    response_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Response templates of the GatewayResponse as a string-to-string map of
    /// key-value pairs.
    response_templates: ?[]const aws.map.StringMapEntry = null,

    /// The response type of the associated GatewayResponse
    response_type: GatewayResponseType,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// The HTTP status code of the GatewayResponse.
    status_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .response_parameters = "responseParameters",
        .response_templates = "responseTemplates",
        .response_type = "responseType",
        .rest_api_id = "restApiId",
        .status_code = "statusCode",
    };
};

pub const PutGatewayResponseOutput = @import("gateway_response.zig").GatewayResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutGatewayResponseInput, options: CallOptions) !PutGatewayResponseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutGatewayResponseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/gatewayresponses/");
    try path_buf.appendSlice(allocator, input.response_type.wireName());
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.status_code) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"statusCode\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutGatewayResponseOutput {
    const result: PutGatewayResponseOutput = try aws.json.parseJsonObject(
        PutGatewayResponseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
