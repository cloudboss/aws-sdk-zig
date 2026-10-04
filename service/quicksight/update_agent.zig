const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomPromptInput = @import("custom_prompt_input.zig").CustomPromptInput;
const AgentStatus = @import("agent_status.zig").AgentStatus;
const FailedToUpdateAssociation = @import("failed_to_update_association.zig").FailedToUpdateAssociation;

pub const UpdateAgentInput = struct {
    /// The Amazon Resource Names (ARNs) of the action connectors to attach to the
    /// agent.
    action_connectors_to_add: ?[]const []const u8 = null,

    /// The Amazon Resource Names (ARNs) of the action connectors to detach from the
    /// agent.
    action_connectors_to_remove: ?[]const []const u8 = null,

    /// The unique identifier for the agent to update.
    agent_id: []const u8,

    /// The ID of the Amazon Web Services account that contains the agent.
    aws_account_id: []const u8,

    /// The custom prompt configuration for the agent.
    custom_prompt_input: ?CustomPromptInput = null,

    /// A description of the agent.
    description: ?[]const u8 = null,

    /// The icon identifier for the agent.
    icon_id: ?[]const u8 = null,

    /// The name of the agent.
    name: []const u8,

    /// The Amazon Resource Names (ARNs) of the spaces to attach to the agent.
    spaces_to_add: ?[]const []const u8 = null,

    /// The Amazon Resource Names (ARNs) of the spaces to detach from the agent.
    spaces_to_remove: ?[]const []const u8 = null,

    /// A list of starter prompts that are displayed to users when they begin
    /// interacting with the agent.
    starter_prompts: ?[]const []const u8 = null,

    /// The welcome message that is displayed when a user starts a conversation with
    /// the agent.
    welcome_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_connectors_to_add = "ActionConnectorsToAdd",
        .action_connectors_to_remove = "ActionConnectorsToRemove",
        .agent_id = "AgentId",
        .aws_account_id = "AwsAccountId",
        .custom_prompt_input = "CustomPromptInput",
        .description = "Description",
        .icon_id = "IconId",
        .name = "Name",
        .spaces_to_add = "SpacesToAdd",
        .spaces_to_remove = "SpacesToRemove",
        .starter_prompts = "StarterPrompts",
        .welcome_message = "WelcomeMessage",
    };
};

pub const UpdateAgentOutput = struct {
    /// The unique identifier for the agent.
    agent_id: []const u8,

    /// The status of the agent.
    agent_status: AgentStatus,

    /// The Amazon Resource Name (ARN) of the agent.
    arn: []const u8,

    /// A list of per-ARN failures from the action connectors that were requested to
    /// be added.
    failed_to_add_action_connectors: ?[]const FailedToUpdateAssociation = null,

    /// A list of per-ARN failures from the spaces that were requested to be added.
    failed_to_add_spaces: ?[]const FailedToUpdateAssociation = null,

    /// A list of per-ARN failures from the action connectors that were requested to
    /// be removed.
    failed_to_remove_action_connectors: ?[]const FailedToUpdateAssociation = null,

    /// A list of per-ARN failures from the spaces that were requested to be
    /// removed.
    failed_to_remove_spaces: ?[]const FailedToUpdateAssociation = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_id = "AgentId",
        .agent_status = "AgentStatus",
        .arn = "Arn",
        .failed_to_add_action_connectors = "FailedToAddActionConnectors",
        .failed_to_add_spaces = "FailedToAddSpaces",
        .failed_to_remove_action_connectors = "FailedToRemoveActionConnectors",
        .failed_to_remove_spaces = "FailedToRemoveSpaces",
        .request_id = "RequestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAgentInput, options: CallOptions) !UpdateAgentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.agent_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.action_connectors_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ActionConnectorsToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.action_connectors_to_remove) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ActionConnectorsToRemove\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_prompt_input) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CustomPromptInput\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.icon_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IconId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.spaces_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SpacesToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.spaces_to_remove) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SpacesToRemove\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.starter_prompts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StarterPrompts\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.welcome_message) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WelcomeMessage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAgentOutput {
    const result: UpdateAgentOutput = try aws.json.parseJsonObject(
        UpdateAgentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
