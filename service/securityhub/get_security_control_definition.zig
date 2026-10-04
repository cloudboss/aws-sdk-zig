const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SecurityControlDefinition = @import("security_control_definition.zig").SecurityControlDefinition;

pub const GetSecurityControlDefinitionInput = struct {
    /// The ID of the security control to retrieve the definition for. This field
    /// doesn’t accept an Amazon Resource Name (ARN).
    security_control_id: []const u8,

    pub const json_field_names = .{
        .security_control_id = "SecurityControlId",
    };
};

pub const GetSecurityControlDefinitionOutput = struct {
    security_control_definition: ?SecurityControlDefinition = null,

    pub const json_field_names = .{
        .security_control_definition = "SecurityControlDefinition",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSecurityControlDefinitionInput, options: CallOptions) !GetSecurityControlDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSecurityControlDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/securityControl/definition";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "SecurityControlId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.security_control_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSecurityControlDefinitionOutput {
    var result: GetSecurityControlDefinitionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSecurityControlDefinitionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
