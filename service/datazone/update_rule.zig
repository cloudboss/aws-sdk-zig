const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleDetail = @import("rule_detail.zig").RuleDetail;
const RuleScope = @import("rule_scope.zig").RuleScope;
const RuleAction = @import("rule_action.zig").RuleAction;
const RuleType = @import("rule_type.zig").RuleType;
const RuleTarget = @import("rule_target.zig").RuleTarget;

pub const UpdateRuleInput = struct {
    /// The description of the rule.
    description: ?[]const u8 = null,

    /// The detail of the rule.
    detail: ?RuleDetail = null,

    /// The ID of the domain in which a rule is to be updated.
    domain_identifier: []const u8,

    /// The ID of the rule that is to be updated
    identifier: []const u8,

    /// Specifies whether to update this rule in the child domain units.
    include_child_domain_units: ?bool = null,

    /// The name of the rule.
    name: ?[]const u8 = null,

    /// The scrope of the rule.
    scope: ?RuleScope = null,

    pub const json_field_names = .{
        .description = "description",
        .detail = "detail",
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .include_child_domain_units = "includeChildDomainUnits",
        .name = "name",
        .scope = "scope",
    };
};

pub const UpdateRuleOutput = struct {
    /// The action of the rule.
    action: RuleAction,

    /// The timestamp at which the rule was created.
    created_at: i64,

    /// The user who created the rule.
    created_by: []const u8,

    /// The description of the rule.
    description: ?[]const u8 = null,

    /// The detail of the rule.
    detail: ?RuleDetail = null,

    /// The ID of the rule.
    identifier: []const u8,

    /// The timestamp at which the rule was last updated.
    last_updated_by: []const u8,

    /// The name of the rule.
    name: []const u8,

    /// The revision of the rule.
    revision: []const u8,

    /// The type of the rule.
    rule_type: RuleType,

    /// The scope of the rule.
    scope: ?RuleScope = null,

    /// The target of the rule.
    target: ?RuleTarget = null,

    /// The timestamp at which the rule was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .action = "action",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .detail = "detail",
        .identifier = "identifier",
        .last_updated_by = "lastUpdatedBy",
        .name = "name",
        .revision = "revision",
        .rule_type = "ruleType",
        .scope = "scope",
        .target = "target",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRuleInput, options: CallOptions) !UpdateRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/rules/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.detail) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"detail\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_child_domain_units) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"includeChildDomainUnits\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scope) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scope\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRuleOutput {
    const result: UpdateRuleOutput = try aws.json.parseJsonObject(
        UpdateRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
