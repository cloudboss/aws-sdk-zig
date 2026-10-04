const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AIGuardrailData = @import("ai_guardrail_data.zig").AIGuardrailData;

pub const CreateAIGuardrailVersionInput = struct {
    /// The identifier of the Amazon Q in Connect AI Guardrail.
    ai_guardrail_id: []const u8,

    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If not provided, the Amazon Web Services SDK
    /// populates this field. For more information about idempotency, see [Making
    /// retries safe with idempotent
    /// APIs](http://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/)..
    client_token: ?[]const u8 = null,

    /// The time the AI Guardrail was last modified.
    modified_time: ?i64 = null,

    pub const json_field_names = .{
        .ai_guardrail_id = "aiGuardrailId",
        .assistant_id = "assistantId",
        .client_token = "clientToken",
        .modified_time = "modifiedTime",
    };
};

pub const CreateAIGuardrailVersionOutput = struct {
    /// The data of the AI Guardrail version.
    ai_guardrail: ?AIGuardrailData = null,

    /// The version number of the AI Guardrail version.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .ai_guardrail = "aiGuardrail",
        .version_number = "versionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAIGuardrailVersionInput, options: CallOptions) !CreateAIGuardrailVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAIGuardrailVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/aiguardrails/");
    try path_buf.appendSlice(allocator, input.ai_guardrail_id);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.modified_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"modifiedTime\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAIGuardrailVersionOutput {
    var result: CreateAIGuardrailVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAIGuardrailVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
