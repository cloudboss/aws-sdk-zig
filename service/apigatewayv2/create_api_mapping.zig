const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateApiMappingInput = struct {
    /// The API identifier.
    api_id: []const u8,

    /// The API mapping key.
    api_mapping_key: ?[]const u8 = null,

    /// The domain name.
    domain_name: []const u8,

    /// The API stage.
    stage: []const u8,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .api_mapping_key = "ApiMappingKey",
        .domain_name = "DomainName",
        .stage = "Stage",
    };
};

pub const CreateApiMappingOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApiMappingInput, options: CallOptions) !CreateApiMappingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApiMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domainnames/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/apimappings");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ApiId\":");
    try aws.json.writeValue(@TypeOf(input.api_id), input.api_id, allocator, &body_buf);
    has_prev = true;
    if (input.api_mapping_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ApiMappingKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Stage\":");
    try aws.json.writeValue(@TypeOf(input.stage), input.stage, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApiMappingOutput {
    const result: CreateApiMappingOutput = try aws.json.parseJsonObject(
        CreateApiMappingOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
