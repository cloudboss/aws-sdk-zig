const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RetrievalConfiguration = @import("retrieval_configuration.zig").RetrievalConfiguration;
const RetrieveError = @import("retrieve_error.zig").RetrieveError;
const RetrieveResult = @import("retrieve_result.zig").RetrieveResult;

pub const RetrieveInput = struct {
    /// The identifier of the Amazon Q in Connect assistant for content retrieval.
    assistant_id: []const u8,

    /// The configuration for the content retrieval operation.
    retrieval_configuration: RetrievalConfiguration,

    /// The query for content retrieval.
    retrieval_query: []const u8,

    pub const json_field_names = .{
        .assistant_id = "assistantId",
        .retrieval_configuration = "retrievalConfiguration",
        .retrieval_query = "retrievalQuery",
    };
};

pub const RetrieveOutput = struct {
    /// The per-association errors returned when one or more knowledge base
    /// associations fail during a `Retrieve` operation that spans multiple
    /// assistant associations. The overall operation still succeeds and returns the
    /// results from the associations that were queried successfully. This list
    /// contains one entry for each association that failed, up to a maximum of
    /// five.
    errors: ?[]const RetrieveError = null,

    /// The results of the content retrieval operation.
    results: ?[]const RetrieveResult = null,

    pub const json_field_names = .{
        .errors = "errors",
        .results = "results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetrieveInput, options: CallOptions) !RetrieveOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wisdom", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RetrieveInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/retrieve");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"retrievalConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.retrieval_configuration), input.retrieval_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"retrievalQuery\":");
    try aws.json.writeValue(@TypeOf(input.retrieval_query), input.retrieval_query, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RetrieveOutput {
    const result: RetrieveOutput = try aws.json.parseJsonObject(
        RetrieveOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
