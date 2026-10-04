const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreatePresignedNotebookUrlInput = struct {
    /// The session ID.
    session_id: []const u8,

    pub const json_field_names = .{
        .session_id = "SessionId",
    };
};

pub const CreatePresignedNotebookUrlOutput = struct {
    /// The authentication token for the notebook.
    auth_token: []const u8,

    /// The UTC epoch time when the authentication token expires.
    auth_token_expiration_time: i64,

    /// The URL of the notebook. The URL includes the authentication token and
    /// notebook file
    /// name and points directly to the opened notebook.
    notebook_url: []const u8,

    pub const json_field_names = .{
        .auth_token = "AuthToken",
        .auth_token_expiration_time = "AuthTokenExpirationTime",
        .notebook_url = "NotebookUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePresignedNotebookUrlInput, options: CallOptions) !CreatePresignedNotebookUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePresignedNotebookUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.CreatePresignedNotebookUrl");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePresignedNotebookUrlOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreatePresignedNotebookUrlOutput, body, allocator);
}
