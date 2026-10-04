const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleAction = @import("rule_action.zig").RuleAction;
const RuleDetail = @import("rule_detail.zig").RuleDetail;
const RuleScope = @import("rule_scope.zig").RuleScope;
const RuleTarget = @import("rule_target.zig").RuleTarget;
const RuleType = @import("rule_type.zig").RuleType;
const RuleTargetType = @import("rule_target_type.zig").RuleTargetType;

pub const CreateRuleInput = struct {
    /// The action of the rule.
    action: RuleAction,

    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The description of the rule.
    description: ?[]const u8 = null,

    /// The detail of the rule.
    detail: RuleDetail,

    /// The ID of the domain where the rule is created.
    domain_identifier: []const u8,

    /// The name of the rule.
    name: []const u8,

    /// The scope of the rule.
    scope: RuleScope,

    /// The target of the rule.
    target: RuleTarget,

    pub const json_field_names = .{
        .action = "action",
        .client_token = "clientToken",
        .description = "description",
        .detail = "detail",
        .domain_identifier = "domainIdentifier",
        .name = "name",
        .scope = "scope",
        .target = "target",
    };
};

pub const CreateRuleOutput = struct {
    /// The action of the rule.
    action: RuleAction,

    /// The timestamp at which the rule is created.
    created_at: i64,

    /// The user who creates the rule.
    created_by: []const u8,

    /// The description of the rule.
    description: ?[]const u8 = null,

    /// The detail of the rule.
    detail: ?RuleDetail = null,

    /// The ID of the rule.
    identifier: []const u8,

    /// The name of the rule.
    name: []const u8,

    /// The type of the rule.
    rule_type: RuleType,

    /// The scope of the rule.
    scope: ?RuleScope = null,

    /// The target of the rule.
    target: ?RuleTarget = null,

    /// The target type of the rule.
    target_type: ?RuleTargetType = null,

    pub const json_field_names = .{
        .action = "action",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .detail = "detail",
        .identifier = "identifier",
        .name = "name",
        .rule_type = "ruleType",
        .scope = "scope",
        .target = "target",
        .target_type = "targetType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRuleInput, options: CallOptions) !CreateRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/rules");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
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
    try body_buf.appendSlice(allocator, "\"detail\":");
    try aws.json.writeValue(@TypeOf(input.detail), input.detail, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scope\":");
    try aws.json.writeValue(@TypeOf(input.scope), input.scope, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"target\":");
    try aws.json.writeValue(@TypeOf(input.target), input.target, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRuleOutput {
    const result: CreateRuleOutput = try aws.json.parseJsonObject(
        CreateRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
