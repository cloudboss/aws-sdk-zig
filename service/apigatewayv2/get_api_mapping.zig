const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetApiMappingInput = struct {
    /// The API mapping identifier.
    api_mapping_id: []const u8,

    /// The domain name.
    domain_name: []const u8,

    pub const json_field_names = .{
        .api_mapping_id = "ApiMappingId",
        .domain_name = "DomainName",
    };
};

pub const GetApiMappingOutput = struct {
    /// The API identifier.
    api_id: ?[]const u8 = null,

    /// The API mapping identifier.
    api_mapping_id: ?[]const u8 = null,

    /// The API mapping key.
    api_mapping_key: ?[]const u8 = null,

    /// The API stage.
    stage: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .api_mapping_id = "ApiMappingId",
        .api_mapping_key = "ApiMappingKey",
        .stage = "Stage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApiMappingInput, options: CallOptions) !GetApiMappingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApiMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domainnames/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/apimappings/");
    try path_buf.appendSlice(allocator, input.api_mapping_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApiMappingOutput {
    const result: GetApiMappingOutput = try aws.json.parseJsonObject(
        GetApiMappingOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
