const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Action = @import("action.zig").Action;
const Condition = @import("condition.zig").Condition;
const GatewayRuleStatus = @import("gateway_rule_status.zig").GatewayRuleStatus;
const SystemManagedBlock = @import("system_managed_block.zig").SystemManagedBlock;

pub const CreateGatewayRuleInput = struct {
    /// The actions to take when the rule conditions are met. Actions can route to a
    /// specific target or apply a configuration bundle override.
    actions: []const Action,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The conditions that must be met for the rule to apply. Conditions can match
    /// on principals (IAM ARNs) or request paths.
    conditions: ?[]const Condition = null,

    /// The description of the gateway rule.
    description: ?[]const u8 = null,

    /// The identifier of the gateway to create a rule for.
    gateway_identifier: []const u8,

    /// The priority of the rule. Rules are evaluated in order of priority, with
    /// lower numbers evaluated first. Must be between 1 and 1,000,000.
    priority: i32,

    pub const json_field_names = .{
        .actions = "actions",
        .client_token = "clientToken",
        .conditions = "conditions",
        .description = "description",
        .gateway_identifier = "gatewayIdentifier",
        .priority = "priority",
    };
};

pub const CreateGatewayRuleOutput = struct {
    /// The actions to take when the rule conditions are met.
    actions: ?[]const Action = null,

    /// The conditions that must be met for the rule to apply.
    conditions: ?[]const Condition = null,

    /// The timestamp when the rule was created.
    created_at: i64,

    /// The description of the gateway rule.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the gateway that the rule belongs to.
    gateway_arn: []const u8,

    /// The priority of the rule. Rules are evaluated in order of priority, with
    /// lower numbers evaluated first.
    priority: i32,

    /// The unique identifier of the gateway rule.
    rule_id: []const u8,

    /// The current status of the rule.
    status: GatewayRuleStatus,

    /// System-managed metadata for rules created by automated processes.
    system: ?SystemManagedBlock = null,

    pub const json_field_names = .{
        .actions = "actions",
        .conditions = "conditions",
        .created_at = "createdAt",
        .description = "description",
        .gateway_arn = "gatewayArn",
        .priority = "priority",
        .rule_id = "ruleId",
        .status = "status",
        .system = "system",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGatewayRuleInput, options: CallOptions) !CreateGatewayRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGatewayRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/rules");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actions\":");
    try aws.json.writeValue(@TypeOf(input.actions), input.actions, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.conditions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"conditions\":");
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
    try body_buf.appendSlice(allocator, "\"priority\":");
    try aws.json.writeValue(@TypeOf(input.priority), input.priority, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGatewayRuleOutput {
    var result: CreateGatewayRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateGatewayRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
