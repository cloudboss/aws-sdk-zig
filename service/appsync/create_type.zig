const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TypeDefinitionFormat = @import("type_definition_format.zig").TypeDefinitionFormat;
const Type = @import("type.zig").Type;

pub const CreateTypeInput = struct {
    /// The API ID.
    api_id: []const u8,

    /// The type definition, in GraphQL Schema Definition Language (SDL) format.
    ///
    /// For more information, see the [GraphQL SDL
    /// documentation](http://graphql.org/learn/schema/).
    definition: []const u8,

    /// The type format: SDL or JSON.
    format: TypeDefinitionFormat,

    pub const json_field_names = .{
        .api_id = "apiId",
        .definition = "definition",
        .format = "format",
    };
};

pub const CreateTypeOutput = struct {
    /// The `Type` object.
    @"type": ?Type = null,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTypeInput, options: CallOptions) !CreateTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appsync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/types");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"definition\":");
    try aws.json.writeValue(@TypeOf(input.definition), input.definition, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"format\":");
    try aws.json.writeValue(@TypeOf(input.format), input.format, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTypeOutput {
    const result: CreateTypeOutput = try aws.json.parseJsonObject(
        CreateTypeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
