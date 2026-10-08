const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotebookType = @import("notebook_type.zig").NotebookType;

pub const UpdateNotebookInput = struct {
    /// A unique case-sensitive string used to ensure the request to create the
    /// notebook is
    /// idempotent (executes only once).
    ///
    /// This token is listed as not required because Amazon Web Services SDKs (for
    /// example
    /// the Amazon Web Services SDK for Java) auto-generate the token for you. If
    /// you are not
    /// using the Amazon Web Services SDK or the Amazon Web Services CLI, you must
    /// provide
    /// this token or the action will fail.
    client_request_token: ?[]const u8 = null,

    /// The ID of the notebook to update.
    notebook_id: []const u8,

    /// The updated content for the notebook.
    payload: []const u8,

    /// The active notebook session ID. Required if the notebook has an active
    /// session.
    session_id: ?[]const u8 = null,

    /// The notebook content type. Currently, the only valid type is
    /// `IPYNB`.
    type: NotebookType,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .notebook_id = "NotebookId",
        .payload = "Payload",
        .session_id = "SessionId",
        .type = "Type",
    };
};

pub const UpdateNotebookOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNotebookInput, options: CallOptions) !UpdateNotebookOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNotebookInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.UpdateNotebook");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNotebookOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
