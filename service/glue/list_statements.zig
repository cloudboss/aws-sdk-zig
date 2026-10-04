const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Statement = @import("statement.zig").Statement;

pub const ListStatementsInput = struct {
    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// The origin of the request to list statements.
    request_origin: ?[]const u8 = null,

    /// The Session ID of the statements.
    session_id: []const u8,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .request_origin = "RequestOrigin",
        .session_id = "SessionId",
    };
};

pub const ListStatementsOutput = struct {
    /// A continuation token, if not all statements have yet been returned.
    next_token: ?[]const u8 = null,

    /// Returns the list of statements.
    statements: ?[]const Statement = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .statements = "Statements",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStatementsInput, options: CallOptions) !ListStatementsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStatementsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.ListStatements");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStatementsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListStatementsOutput, body, allocator);
}
