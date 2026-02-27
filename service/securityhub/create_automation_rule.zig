const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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
    /// Security Hub uses to filter findings. If a rule is enabled and a finding
    /// matches the conditions specified in
    /// this parameter, Security Hub applies the rule action to the finding.
    criteria: AutomationRulesFindingFilters,

    /// A description of the rule.
    description: []const u8,

    /// Specifies whether a rule is the last to be applied with respect to a finding
    /// that matches the rule criteria. This is useful when a finding
    /// matches the criteria for multiple rules, and each rule has different
    /// actions. If a rule is terminal, Security Hub applies the rule action to a
    /// finding that matches
    /// the rule criteria and doesn't evaluate other rules for the finding. By
    /// default, a rule isn't terminal.
    is_terminal: ?bool = null,

    /// The name of the rule.
    rule_name: []const u8,

    /// An integer ranging from 1 to 1000 that represents the order in which the
    /// rule action is
    /// applied to findings. Security Hub applies rules with lower values for this
    /// parameter
    /// first.
    rule_order: i32,

    /// Whether the rule is active after it is created. If
    /// this parameter is equal to `ENABLED`, Security Hub starts applying the rule
    /// to findings
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutomationRuleInput, options: Options) !CreateAutomationRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "securityhub");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateAutomationRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/automationrules/create";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Actions\":");
    try aws.json.writeValue(@TypeOf(input.actions), input.actions, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Criteria\":");
    try aws.json.writeValue(@TypeOf(input.criteria), input.criteria, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, alloc, &body_buf);
    has_prev = true;
    if (input.is_terminal) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IsTerminal\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"RuleName\":");
    try aws.json.writeValue(@TypeOf(input.rule_name), input.rule_name, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"RuleOrder\":");
    try aws.json.writeValue(@TypeOf(input.rule_order), input.rule_order, alloc, &body_buf);
    has_prev = true;
    if (input.rule_status) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"RuleStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateAutomationRuleOutput {
    var result: CreateAutomationRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAutomationRuleOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidAccessException")) {
        return .{ .arena = arena, .kind = .{ .invalid_access_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
