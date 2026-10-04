const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AIAgentConfigurationData = @import("ai_agent_configuration_data.zig").AIAgentConfigurationData;
const OrchestratorConfigurationEntry = @import("orchestrator_configuration_entry.zig").OrchestratorConfigurationEntry;
const TagFilter = @import("tag_filter.zig").TagFilter;
const SessionData = @import("session_data.zig").SessionData;

pub const CreateSessionInput = struct {
    /// The configuration of the AI Agents (mapped by AI Agent Type to AI Agent
    /// version) that should be used by Amazon Q in Connect for this Session.
    ai_agent_configuration: ?[]const aws.map.MapEntry(AIAgentConfigurationData) = null,

    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If not provided, the Amazon Web Services SDK
    /// populates this field. For more information about idempotency, see [Making
    /// retries safe with idempotent
    /// APIs](http://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the email contact in Amazon Connect. Used
    /// to retrieve email content and establish session context for AI-powered email
    /// assistance.
    contact_arn: ?[]const u8 = null,

    /// The description.
    description: ?[]const u8 = null,

    /// The name of the session.
    name: []const u8,

    /// The list of orchestrator configurations for the session being created.
    orchestrator_configuration_list: ?[]const OrchestratorConfigurationEntry = null,

    /// The list of orchestrator configurations to remove from the session.
    remove_orchestrator_configuration_list: ?bool = null,

    /// An object that can be used to specify Tag conditions.
    tag_filter: ?TagFilter = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .ai_agent_configuration = "aiAgentConfiguration",
        .assistant_id = "assistantId",
        .client_token = "clientToken",
        .contact_arn = "contactArn",
        .description = "description",
        .name = "name",
        .orchestrator_configuration_list = "orchestratorConfigurationList",
        .remove_orchestrator_configuration_list = "removeOrchestratorConfigurationList",
        .tag_filter = "tagFilter",
        .tags = "tags",
    };
};

pub const CreateSessionOutput = @import("create_session_response.zig").CreateSessionResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSessionInput, options: CallOptions) !CreateSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/sessions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.ai_agent_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"aiAgentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.contact_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contactArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.orchestrator_configuration_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"orchestratorConfigurationList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remove_orchestrator_configuration_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"removeOrchestratorConfigurationList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tag_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tagFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSessionOutput {
    var result: CreateSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
