const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ActionGroupExecutor = @import("action_group_executor.zig").ActionGroupExecutor;
const ActionGroupState = @import("action_group_state.zig").ActionGroupState;
const APISchema = @import("api_schema.zig").APISchema;
const FunctionSchema = @import("function_schema.zig").FunctionSchema;
const ActionGroupSignature = @import("action_group_signature.zig").ActionGroupSignature;
const AgentActionGroup = @import("agent_action_group.zig").AgentActionGroup;

pub const UpdateAgentActionGroupInput = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function containing the
    /// business logic that is carried out upon invoking the action.
    action_group_executor: ?ActionGroupExecutor = null,

    /// The unique identifier of the action group.
    action_group_id: []const u8,

    /// Specifies a new name for the action group.
    action_group_name: []const u8,

    /// Specifies whether the action group is available for the agent to invoke or
    /// not when sending an
    /// [InvokeAgent](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html) request.
    action_group_state: ?ActionGroupState = null,

    /// The unique identifier of the agent for which to update the action group.
    agent_id: []const u8,

    /// The unique identifier of the agent version for which to update the action
    /// group.
    agent_version: []const u8,

    /// Contains either details about the S3 object containing the OpenAPI schema
    /// for the action group or the JSON or YAML-formatted payload defining the
    /// schema. For more information, see [Action group OpenAPI
    /// schemas](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-api-schema.html).
    api_schema: ?APISchema = null,

    /// Specifies a new name for the action group.
    description: ?[]const u8 = null,

    /// Contains details about the function schema for the action group or the JSON
    /// or YAML-formatted payload defining the schema.
    function_schema: ?FunctionSchema = null,

    /// Update the built-in or computer use action for this action group. If you
    /// specify a value, you must leave the `description`, `apiSchema`, and
    /// `actionGroupExecutor` fields empty for this action group.
    ///
    /// * To allow your agent to request the user for additional information when
    ///   trying to complete a task, set this field to `AMAZON.UserInput`.
    /// * To allow your agent to generate, run, and troubleshoot code when trying to
    ///   complete a task, set this field to `AMAZON.CodeInterpreter`.
    /// * To allow your agent to use an Anthropic computer use tool, specify one of
    ///   the following values.
    ///
    /// Computer use is a new Anthropic Claude model capability (in beta) available
    /// with Anthropic Claude 3.7 Sonnet and Claude 3.5 Sonnet v2 only. When
    /// operating computer use functionality, we recommend taking additional
    /// security precautions, such as executing computer actions in virtual
    /// environments with restricted data access and limited internet connectivity.
    /// For more information, see [Configure an Amazon Bedrock Agent to complete
    /// tasks with computer use
    /// tools](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-computer-use.html).
    ///
    /// * `ANTHROPIC.Computer` - Gives the agent permission to use the mouse and
    ///   keyboard and take screenshots.
    /// * `ANTHROPIC.TextEditor` - Gives the agent permission to view, create and
    ///   edit files.
    /// * `ANTHROPIC.Bash` - Gives the agent permission to run commands in a bash
    ///   shell.
    ///
    /// During orchestration, if your agent determines that it needs to invoke an
    /// API in an action group, but doesn't have enough information to complete the
    /// API request, it will invoke this action group instead and return an
    /// [Observation](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Observation.html) reprompting the user for more information.
    parent_action_group_signature: ?ActionGroupSignature = null,

    /// The configuration settings for a computer use action.
    ///
    /// Computer use is a new Anthropic Claude model capability (in beta) available
    /// with Claude 3.7 Sonnet and Claude 3.5 Sonnet v2 only. For more information,
    /// see [Configure an Amazon Bedrock Agent to complete tasks with computer use
    /// tools](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-computer-use.html).
    parent_action_group_signature_params: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .action_group_executor = "actionGroupExecutor",
        .action_group_id = "actionGroupId",
        .action_group_name = "actionGroupName",
        .action_group_state = "actionGroupState",
        .agent_id = "agentId",
        .agent_version = "agentVersion",
        .api_schema = "apiSchema",
        .description = "description",
        .function_schema = "functionSchema",
        .parent_action_group_signature = "parentActionGroupSignature",
        .parent_action_group_signature_params = "parentActionGroupSignatureParams",
    };
};

pub const UpdateAgentActionGroupOutput = struct {
    /// Contains details about the action group that was updated.
    agent_action_group: ?AgentActionGroup = null,

    pub const json_field_names = .{
        .agent_action_group = "agentActionGroup",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAgentActionGroupInput, options: Options) !UpdateAgentActionGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrockagent");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAgentActionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockagent", "Bedrock Agent", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.agent_id);
    try path_buf.appendSlice(allocator, "/agentversions/");
    try path_buf.appendSlice(allocator, input.agent_version);
    try path_buf.appendSlice(allocator, "/actiongroups/");
    try path_buf.appendSlice(allocator, input.action_group_id);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.action_group_executor) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"actionGroupExecutor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actionGroupName\":");
    try aws.json.writeValue(@TypeOf(input.action_group_name), input.action_group_name, allocator, &body_buf);
    has_prev = true;
    if (input.action_group_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"actionGroupState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.api_schema) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"apiSchema\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.function_schema) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"functionSchema\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_action_group_signature) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentActionGroupSignature\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_action_group_signature_params) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentActionGroupSignatureParams\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAgentActionGroupOutput {
    var result: UpdateAgentActionGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAgentActionGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
