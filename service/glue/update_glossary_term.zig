const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateGlossaryTermInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The unique identifier of the glossary term to update.
    identifier: []const u8,

    /// The updated long description of the glossary term.
    long_description: ?[]const u8 = null,

    /// The updated name of the glossary term.
    name: ?[]const u8 = null,

    /// The updated short description of the glossary term.
    short_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .identifier = "Identifier",
        .long_description = "LongDescription",
        .name = "Name",
        .short_description = "ShortDescription",
    };
};

pub const UpdateGlossaryTermOutput = struct {
    /// The unique identifier of the glossary containing this term.
    glossary_id: ?[]const u8 = null,

    /// The unique identifier of the glossary term.
    id: ?[]const u8 = null,

    /// The long description of the glossary term.
    long_description: ?[]const u8 = null,

    /// The name of the glossary term.
    name: ?[]const u8 = null,

    /// The short description of the glossary term.
    short_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .glossary_id = "GlossaryId",
        .id = "Id",
        .long_description = "LongDescription",
        .name = "Name",
        .short_description = "ShortDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGlossaryTermInput, options: CallOptions) !UpdateGlossaryTermOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGlossaryTermInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.UpdateGlossaryTerm");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGlossaryTermOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateGlossaryTermOutput, body, allocator);
}
