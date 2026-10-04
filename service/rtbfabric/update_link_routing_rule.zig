const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleCondition = @import("rule_condition.zig").RuleCondition;
const RuleStatus = @import("rule_status.zig").RuleStatus;

pub const UpdateLinkRoutingRuleInput = struct {
    /// The updated conditions for the routing rule. All specified fields must match
    /// for the rule to apply. At least one condition field must be set.
    conditions: RuleCondition,

    /// The unique identifier of the gateway.
    gateway_id: []const u8,

    /// The unique identifier of the link.
    link_id: []const u8,

    /// The updated priority of the routing rule. Lower numbers are evaluated first.
    /// Valid values are 1 to 1000. Priority must be unique among non-deleted rules
    /// within a link.
    priority: i32,

    /// The unique identifier of the routing rule.
    rule_id: []const u8,

    pub const json_field_names = .{
        .conditions = "conditions",
        .gateway_id = "gatewayId",
        .link_id = "linkId",
        .priority = "priority",
        .rule_id = "ruleId",
    };
};

pub const UpdateLinkRoutingRuleOutput = struct {
    /// The unique identifier of the routing rule.
    rule_id: []const u8,

    /// The status of the routing rule.
    status: RuleStatus,

    /// The timestamp of when the routing rule was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .rule_id = "ruleId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLinkRoutingRuleInput, options: CallOptions) !UpdateLinkRoutingRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rtbfabric", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLinkRoutingRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rtbfabric", "RTBFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/responder-gateway/");
    try path_buf.appendSlice(allocator, input.gateway_id);
    try path_buf.appendSlice(allocator, "/link/");
    try path_buf.appendSlice(allocator, input.link_id);
    try path_buf.appendSlice(allocator, "/routing-rule/");
    try path_buf.appendSlice(allocator, input.rule_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"conditions\":");
    try aws.json.writeValue(@TypeOf(input.conditions), input.conditions, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"priority\":");
    try aws.json.writeValue(@TypeOf(input.priority), input.priority, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLinkRoutingRuleOutput {
    const result: UpdateLinkRoutingRuleOutput = try aws.json.parseJsonObject(
        UpdateLinkRoutingRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
