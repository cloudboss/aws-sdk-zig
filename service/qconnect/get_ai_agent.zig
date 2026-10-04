const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AIAgentData = @import("ai_agent_data.zig").AIAgentData;

pub const GetAIAgentInput = struct {
    /// The identifier of the Amazon Q in Connect AI Agent (with or without a
    /// version qualifier). Can be either the ID or the ARN. URLs cannot contain the
    /// ARN.
    ai_agent_id: []const u8,

    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    pub const json_field_names = .{
        .ai_agent_id = "aiAgentId",
        .assistant_id = "assistantId",
    };
};

pub const GetAIAgentOutput = struct {
    /// The data of the AI Agent.
    ai_agent: ?AIAgentData = null,

    /// The version number of the AI Agent version (returned if an AI Agent version
    /// was specified via use of a qualifier for the `aiAgentId` on the request).
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .ai_agent = "aiAgent",
        .version_number = "versionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAIAgentInput, options: CallOptions) !GetAIAgentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAIAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/aiagents/");
    try path_buf.appendSlice(allocator, input.ai_agent_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAIAgentOutput {
    const result: GetAIAgentOutput = try aws.json.parseJsonObject(
        GetAIAgentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
