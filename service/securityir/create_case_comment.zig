const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateCaseCommentInput = struct {
    /// Required element used in combination with CreateCaseComment to add content
    /// for the new comment.
    body: []const u8,

    /// Required element used in combination with CreateCaseComment to specify a
    /// case ID.
    case_id: []const u8,

    /// The `clientToken` field is an idempotency key used to ensure that repeated
    /// attempts for a single action will be ignored by the server during retries. A
    /// caller supplied unique ID (typically a UUID) should be provided.
    client_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "body",
        .case_id = "caseId",
        .client_token = "clientToken",
    };
};

pub const CreateCaseCommentOutput = struct {
    /// Response element indicating the new comment ID.
    comment_id: []const u8,

    pub const json_field_names = .{
        .comment_id = "commentId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCaseCommentInput, options: CallOptions) !CreateCaseCommentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "security-ir", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCaseCommentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    try path_buf.appendSlice(allocator, "/create-comment");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"body\":");
    try aws.json.writeValue(@TypeOf(input.body), input.body, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCaseCommentOutput {
    const result: CreateCaseCommentOutput = try aws.json.parseJsonObject(
        CreateCaseCommentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
