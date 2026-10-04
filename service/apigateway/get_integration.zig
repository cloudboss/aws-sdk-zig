const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const ContentHandlingStrategy = @import("content_handling_strategy.zig").ContentHandlingStrategy;
const IntegrationResponse = @import("integration_response.zig").IntegrationResponse;
const ResponseTransferMode = @import("response_transfer_mode.zig").ResponseTransferMode;
const TlsConfig = @import("tls_config.zig").TlsConfig;
const IntegrationType = @import("integration_type.zig").IntegrationType;

pub const GetIntegrationInput = struct {
    /// Specifies a get integration request's HTTP method.
    http_method: []const u8,

    /// Specifies a get integration request's resource identifier
    resource_id: []const u8,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    pub const json_field_names = .{
        .http_method = "httpMethod",
        .resource_id = "resourceId",
        .rest_api_id = "restApiId",
    };
};

pub const GetIntegrationOutput = @import("integration.zig").Integration;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIntegrationInput, options: CallOptions) !GetIntegrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/resources/");
    try path_buf.appendSlice(allocator, input.resource_id);
    try path_buf.appendSlice(allocator, "/methods/");
    try path_buf.appendSlice(allocator, input.http_method);
    try path_buf.appendSlice(allocator, "/integration");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIntegrationOutput {
    var result: GetIntegrationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetIntegrationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
