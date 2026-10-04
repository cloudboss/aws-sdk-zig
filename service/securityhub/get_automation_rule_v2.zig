const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomationRulesActionV2 = @import("automation_rules_action_v2.zig").AutomationRulesActionV2;
const Criteria = @import("criteria.zig").Criteria;
const RuleStatusV2 = @import("rule_status_v2.zig").RuleStatusV2;

pub const GetAutomationRuleV2Input = struct {
    /// The ARN of the V2 automation rule.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetAutomationRuleV2Output = struct {
    /// A list of actions performed when the rule criteria is met.
    actions: ?[]const AutomationRulesActionV2 = null,

    /// The timestamp when the V2 automation rule was created.
    created_at: ?i64 = null,

    /// The filtering type and configuration of the V2 automation rule.
    criteria: ?Criteria = null,

    /// A description of the automation rule.
    description: ?[]const u8 = null,

    /// The ARN of the V2 automation rule.
    rule_arn: ?[]const u8 = null,

    /// The ID of the V2 automation rule.
    rule_id: ?[]const u8 = null,

    /// The name of the V2 automation rule.
    rule_name: ?[]const u8 = null,

    /// The value for the rule priority.
    rule_order: ?f32 = null,

    /// The status of the V2 automation automation rule.
    rule_status: ?RuleStatusV2 = null,

    /// The timestamp when the V2 automation rule was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .created_at = "CreatedAt",
        .criteria = "Criteria",
        .description = "Description",
        .rule_arn = "RuleArn",
        .rule_id = "RuleId",
        .rule_name = "RuleName",
        .rule_order = "RuleOrder",
        .rule_status = "RuleStatus",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutomationRuleV2Input, options: CallOptions) !GetAutomationRuleV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAutomationRuleV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automationrulesv2/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAutomationRuleV2Output {
    const result: GetAutomationRuleV2Output = try aws.json.parseJsonObject(
        GetAutomationRuleV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
