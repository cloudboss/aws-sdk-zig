const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Action = @import("action.zig").Action;
const Condition = @import("condition.zig").Condition;
const GatewayRuleStatus = @import("gateway_rule_status.zig").GatewayRuleStatus;
const SystemManagedBlock = @import("system_managed_block.zig").SystemManagedBlock;

pub const GetGatewayRuleInput = struct {
    /// The identifier of the gateway containing the rule.
    gateway_identifier: []const u8,

    /// The unique identifier of the rule to retrieve.
    rule_id: []const u8,

    pub const json_field_names = .{
        .gateway_identifier = "gatewayIdentifier",
        .rule_id = "ruleId",
    };
};

pub const GetGatewayRuleOutput = struct {
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

    /// The timestamp when the rule was last updated.
    updated_at: ?i64 = null,

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
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGatewayRuleInput, options: CallOptions) !GetGatewayRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGatewayRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/rules/");
    try path_buf.appendSlice(allocator, input.rule_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGatewayRuleOutput {
    var result: GetGatewayRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetGatewayRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
