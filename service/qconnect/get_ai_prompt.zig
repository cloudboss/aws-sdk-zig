const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AIPromptData = @import("ai_prompt_data.zig").AIPromptData;

pub const GetAIPromptInput = struct {
    /// The identifier of the Amazon Q in Connect AI prompt.
    ai_prompt_id: []const u8,

    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    pub const json_field_names = .{
        .ai_prompt_id = "aiPromptId",
        .assistant_id = "assistantId",
    };
};

pub const GetAIPromptOutput = struct {
    /// The data of the AI Prompt.
    ai_prompt: ?AIPromptData = null,

    /// The version number of the AI Prompt version (returned if an AI Prompt
    /// version was specified via use of a qualifier for the `aiPromptId` on the
    /// request).
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .ai_prompt = "aiPrompt",
        .version_number = "versionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAIPromptInput, options: CallOptions) !GetAIPromptOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAIPromptInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/aiprompts/");
    try path_buf.appendSlice(allocator, input.ai_prompt_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAIPromptOutput {
    const result: GetAIPromptOutput = try aws.json.parseJsonObject(
        GetAIPromptOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
