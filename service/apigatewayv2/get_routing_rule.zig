const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoutingRuleAction = @import("routing_rule_action.zig").RoutingRuleAction;
const RoutingRuleCondition = @import("routing_rule_condition.zig").RoutingRuleCondition;

pub const GetRoutingRuleInput = struct {
    /// The domain name.
    domain_name: []const u8,

    /// The domain name ID.
    domain_name_id: ?[]const u8 = null,

    /// The routing rule ID.
    routing_rule_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .domain_name_id = "DomainNameId",
        .routing_rule_id = "RoutingRuleId",
    };
};

pub const GetRoutingRuleOutput = struct {
    /// The resulting action based on matching a routing rules condition. Only
    /// InvokeApi is supported.
    actions: ?[]const RoutingRuleAction = null,

    /// The conditions of the routing rule.
    conditions: ?[]const RoutingRuleCondition = null,

    /// The order in which API Gateway evaluates a rule. Priority is evaluated from
    /// the lowest value to the highest value.
    priority: ?i32 = null,

    /// The routing rule ARN.
    routing_rule_arn: ?[]const u8 = null,

    /// The routing rule ID.
    routing_rule_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .conditions = "Conditions",
        .priority = "Priority",
        .routing_rule_arn = "RoutingRuleArn",
        .routing_rule_id = "RoutingRuleId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRoutingRuleInput, options: CallOptions) !GetRoutingRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRoutingRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domainnames/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/routingrules/");
    try path_buf.appendSlice(allocator, input.routing_rule_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.domain_name_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "domainNameId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRoutingRuleOutput {
    var result: GetRoutingRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRoutingRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
