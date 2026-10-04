const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomationRulesActionV2 = @import("automation_rules_action_v2.zig").AutomationRulesActionV2;
const Criteria = @import("criteria.zig").Criteria;
const RuleStatusV2 = @import("rule_status_v2.zig").RuleStatusV2;

pub const CreateAutomationRuleV2Input = struct {
    /// A list of actions to be performed when the rule criteria is met.
    actions: []const AutomationRulesActionV2,

    /// A unique identifier used to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The filtering type and configuration of the automation rule.
    criteria: Criteria,

    /// A description of the V2 automation rule.
    description: []const u8,

    /// The name of the V2 automation rule.
    rule_name: []const u8,

    /// The value for the rule priority.
    rule_order: f32,

    /// The status of the V2 automation rule.
    rule_status: ?RuleStatusV2 = null,

    /// A list of key-value pairs associated with the V2 automation rule.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .client_token = "ClientToken",
        .criteria = "Criteria",
        .description = "Description",
        .rule_name = "RuleName",
        .rule_order = "RuleOrder",
        .rule_status = "RuleStatus",
        .tags = "Tags",
    };
};

pub const CreateAutomationRuleV2Output = struct {
    /// The ARN of the V2 automation rule.
    rule_arn: ?[]const u8 = null,

    /// The ID of the V2 automation rule.
    rule_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .rule_arn = "RuleArn",
        .rule_id = "RuleId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutomationRuleV2Input, options: CallOptions) !CreateAutomationRuleV2Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAutomationRuleV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/automationrulesv2/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Actions\":");
    try aws.json.writeValue(@TypeOf(input.actions), input.actions, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Criteria\":");
    try aws.json.writeValue(@TypeOf(input.criteria), input.criteria, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RuleName\":");
    try aws.json.writeValue(@TypeOf(input.rule_name), input.rule_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RuleOrder\":");
    try aws.json.writeValue(@TypeOf(input.rule_order), input.rule_order, allocator, &body_buf);
    has_prev = true;
    if (input.rule_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RuleStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAutomationRuleV2Output {
    var result: CreateAutomationRuleV2Output = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAutomationRuleV2Output, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
