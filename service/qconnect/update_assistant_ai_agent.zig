const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AIAgentType = @import("ai_agent_type.zig").AIAgentType;
const AIAgentConfigurationData = @import("ai_agent_configuration_data.zig").AIAgentConfigurationData;
const AssistantData = @import("assistant_data.zig").AssistantData;

pub const UpdateAssistantAIAgentInput = struct {
    /// The type of the AI Agent being updated for use by default on the Amazon Q in
    /// Connect Assistant.
    ai_agent_type: AIAgentType,

    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    /// The configuration of the AI Agent being updated for use by default on the
    /// Amazon Q in Connect Assistant.
    configuration: AIAgentConfigurationData,

    /// The orchestrator use case for the AI Agent being added.
    orchestrator_use_case: ?[]const u8 = null,

    pub const json_field_names = .{
        .ai_agent_type = "aiAgentType",
        .assistant_id = "assistantId",
        .configuration = "configuration",
        .orchestrator_use_case = "orchestratorUseCase",
    };
};

pub const UpdateAssistantAIAgentOutput = struct {
    assistant: ?AssistantData = null,

    pub const json_field_names = .{
        .assistant = "assistant",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssistantAIAgentInput, options: CallOptions) !UpdateAssistantAIAgentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssistantAIAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/aiagentConfiguration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"aiAgentType\":");
    try aws.json.writeValue(@TypeOf(input.ai_agent_type), input.ai_agent_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;
    if (input.orchestrator_use_case) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"orchestratorUseCase\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssistantAIAgentOutput {
    const result: UpdateAssistantAIAgentOutput = try aws.json.parseJsonObject(
        UpdateAssistantAIAgentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
