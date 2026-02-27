const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RoutingRuleAction = @import("routing_rule_action.zig").RoutingRuleAction;
const RoutingRuleCondition = @import("routing_rule_condition.zig").RoutingRuleCondition;

pub const CreateRoutingRuleInput = struct {
    /// Represents a routing rule action. The only supported action is invokeApi.
    actions: []const RoutingRuleAction,

    /// Represents a condition. Conditions can contain up to two matchHeaders
    /// conditions and one matchBasePaths conditions. API Gateway evaluates header
    /// conditions and base path conditions together. You can only use AND between
    /// header and base path conditions.
    conditions: []const RoutingRuleCondition,

    /// The domain name.
    domain_name: []const u8,

    /// The domain name ID.
    domain_name_id: ?[]const u8 = null,

    /// Represents the priority of the routing rule.
    priority: i32,

    pub const json_field_names = .{
        .actions = "Actions",
        .conditions = "Conditions",
        .domain_name = "DomainName",
        .domain_name_id = "DomainNameId",
        .priority = "Priority",
    };
};

pub const CreateRoutingRuleOutput = struct {
    /// Represents a routing rule action. The only supported action is invokeApi.
    actions: ?[]const RoutingRuleAction = null,

    /// Represents a condition. Conditions can contain up to two matchHeaders
    /// conditions and one matchBasePaths conditions. API Gateway evaluates header
    /// conditions and base path conditions together. You can only use AND between
    /// header and base path conditions.
    conditions: ?[]const RoutingRuleCondition = null,

    /// Represents the priority of the routing rule.
    priority: ?i32 = null,

    /// The ARN of the domain name.
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRoutingRuleInput, options: Options) !CreateRoutingRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigatewayv2");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateRoutingRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigatewayv2", "ApiGatewayV2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v2/domainnames/");
    try path_buf.appendSlice(alloc, input.domain_name);
    try path_buf.appendSlice(alloc, "/routingrules");
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.domain_name_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "domainNameId=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Actions\":");
    try aws.json.writeValue(@TypeOf(input.actions), input.actions, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Conditions\":");
    try aws.json.writeValue(@TypeOf(input.conditions), input.conditions, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Priority\":");
    try aws.json.writeValue(@TypeOf(input.priority), input.priority, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateRoutingRuleOutput {
    var result: CreateRoutingRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRoutingRuleOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
