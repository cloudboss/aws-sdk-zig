const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentInputMessage = @import("agent_input_message.zig").AgentInputMessage;
const SourceFormat = @import("source_format.zig").SourceFormat;
const AgentOutputMessage = @import("agent_output_message.zig").AgentOutputMessage;

pub const UpdateProfileWithAgentInput = struct {
    /// The conversation identifier for multi-turn interactions. Omit to start a new
    /// conversation.
    conversation_id: ?[]const u8 = null,

    /// The message to send to the agent.
    input_message: AgentInputMessage,

    /// The unique identifier of the profile to update via the agent.
    profile_id: []const u8,

    /// The source data format for the transformation.
    source_format: SourceFormat,

    pub const json_field_names = .{
        .conversation_id = "ConversationId",
        .input_message = "InputMessage",
        .profile_id = "ProfileId",
        .source_format = "SourceFormat",
    };
};

pub const UpdateProfileWithAgentOutput = struct {
    /// The response message from the agent.
    agent_response: ?AgentOutputMessage = null,

    /// The conversation identifier to use for follow-up messages in this
    /// conversation.
    conversation_id: []const u8,

    pub const json_field_names = .{
        .agent_response = "AgentResponse",
        .conversation_id = "ConversationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProfileWithAgentInput, options: CallOptions) !UpdateProfileWithAgentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "healthlake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProfileWithAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("healthlake", "HealthLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.UpdateProfileWithAgent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProfileWithAgentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateProfileWithAgentOutput, body, allocator);
}
