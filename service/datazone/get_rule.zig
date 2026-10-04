const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleAction = @import("rule_action.zig").RuleAction;
const RuleDetail = @import("rule_detail.zig").RuleDetail;
const RuleType = @import("rule_type.zig").RuleType;
const RuleScope = @import("rule_scope.zig").RuleScope;
const RuleTarget = @import("rule_target.zig").RuleTarget;
const RuleTargetType = @import("rule_target_type.zig").RuleTargetType;

pub const GetRuleInput = struct {
    /// The ID of the domain where the `GetRule` action is to be invoked.
    domain_identifier: []const u8,

    /// The ID of the rule.
    identifier: []const u8,

    /// The revision of the rule.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .revision = "revision",
    };
};

pub const GetRuleOutput = struct {
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

    /// The target type of the rule.
    target_type: ?RuleTargetType = null,

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
        .target_type = "targetType",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRuleInput, options: CallOptions) !GetRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/rules/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.revision) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "revision=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRuleOutput {
    var result: GetRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
