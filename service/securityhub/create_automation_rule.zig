const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomationRulesAction = @import("automation_rules_action.zig").AutomationRulesAction;
const AutomationRulesFindingFilters = @import("automation_rules_finding_filters.zig").AutomationRulesFindingFilters;
const RuleStatus = @import("rule_status.zig").RuleStatus;

pub const CreateAutomationRuleInput = struct {
    /// One or more actions to update finding fields if a finding matches the
    /// conditions
    /// specified in `Criteria`.
    actions: []const AutomationRulesAction,

    /// A set of ASFF finding field attributes and corresponding expected values
    /// that
    /// Security Hub CSPM uses to filter findings. If a rule is enabled and a
    /// finding matches the conditions specified in
    /// this parameter, Security Hub CSPM applies the rule action to the finding.
    criteria: AutomationRulesFindingFilters,

    /// A description of the rule.
    description: []const u8,

    /// Specifies whether a rule is the last to be applied with respect to a finding
    /// that matches the rule criteria. This is useful when a finding
    /// matches the criteria for multiple rules, and each rule has different
    /// actions. If a rule is terminal, Security Hub CSPM applies the rule action to
    /// a finding that matches
    /// the rule criteria and doesn't evaluate other rules for the finding. By
    /// default, a rule isn't terminal.
    is_terminal: ?bool = null,

    /// The name of the rule.
    rule_name: []const u8,

    /// An integer ranging from 1 to 1000 that represents the order in which the
    /// rule action is
    /// applied to findings. Security Hub CSPM applies rules with lower values for
    /// this parameter
    /// first.
    rule_order: i32,

    /// Whether the rule is active after it is created. If
    /// this parameter is equal to `ENABLED`, Security Hub CSPM starts applying the
    /// rule to findings
    /// and finding updates after the rule is created. To change the value of this
    /// parameter after creating a rule, use [
    /// `BatchUpdateAutomationRules`
    /// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateAutomationRules.html).
    rule_status: ?RuleStatus = null,

    /// User-defined tags associated with an automation rule.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .criteria = "Criteria",
        .description = "Description",
        .is_terminal = "IsTerminal",
        .rule_name = "RuleName",
        .rule_order = "RuleOrder",
        .rule_status = "RuleStatus",
        .tags = "Tags",
    };
};

pub const CreateAutomationRuleOutput = struct {
    /// The Amazon Resource Name (ARN) of the automation rule that you created.
    rule_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .rule_arn = "RuleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutomationRuleInput, options: CallOptions) !CreateAutomationRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAutomationRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/automationrules/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Actions\":");
    try aws.json.writeValue(@TypeOf(input.actions), input.actions, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Criteria\":");
    try aws.json.writeValue(@TypeOf(input.criteria), input.criteria, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (input.is_terminal) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IsTerminal\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAutomationRuleOutput {
    const result: CreateAutomationRuleOutput = try aws.json.parseJsonObject(
        CreateAutomationRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
