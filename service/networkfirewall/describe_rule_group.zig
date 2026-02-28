const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RuleGroupType = @import("rule_group_type.zig").RuleGroupType;
const RuleGroup = @import("rule_group.zig").RuleGroup;
const RuleGroupResponse = @import("rule_group_response.zig").RuleGroupResponse;

pub const DescribeRuleGroupInput = struct {
    /// Indicates whether you want Network Firewall to analyze the stateless rules
    /// in the rule group for rule behavior such as asymmetric routing. If set to
    /// `TRUE`, Network Firewall runs the analysis.
    analyze_rule_group: ?bool = null,

    /// The Amazon Resource Name (ARN) of the rule group.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    rule_group_arn: ?[]const u8 = null,

    /// The descriptive name of the rule group. You can't change the name of a rule
    /// group after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    rule_group_name: ?[]const u8 = null,

    /// Indicates whether the rule group is stateless or stateful. If the rule group
    /// is stateless, it contains
    /// stateless rules. If it is stateful, it contains stateful rules.
    ///
    /// This setting is required for requests that do not include the
    /// `RuleGroupARN`.
    @"type": ?RuleGroupType = null,

    pub const json_field_names = .{
        .analyze_rule_group = "AnalyzeRuleGroup",
        .rule_group_arn = "RuleGroupArn",
        .rule_group_name = "RuleGroupName",
        .@"type" = "Type",
    };
};

pub const DescribeRuleGroupOutput = struct {
    /// The object that defines the rules in a rule group. This, along with
    /// RuleGroupResponse, define the rule group. You can retrieve all objects for a
    /// rule group by calling DescribeRuleGroup.
    ///
    /// Network Firewall uses a rule group to inspect and control network traffic.
    /// You define stateless rule groups to inspect individual packets and you
    /// define stateful rule groups to inspect packets in the context of their
    /// traffic flow.
    ///
    /// To use a rule group, you include it by reference in an Network Firewall
    /// firewall policy, then you use the policy in a firewall. You can reference a
    /// rule group from
    /// more than one firewall policy, and you can use a firewall policy in more
    /// than one firewall.
    rule_group: ?RuleGroup = null,

    /// The high-level properties of a rule group. This, along with the RuleGroup,
    /// define the rule group. You can retrieve all objects for a rule group by
    /// calling DescribeRuleGroup.
    rule_group_response: ?RuleGroupResponse = null,

    /// A token used for optimistic locking. Network Firewall returns a token to
    /// your requests that access the rule group. The token marks the state of the
    /// rule group resource at the time of the request.
    ///
    /// To make changes to the rule group, you provide the token in your request.
    /// Network Firewall uses the token to ensure that the rule group hasn't changed
    /// since you last retrieved it. If it has changed, the operation fails with an
    /// `InvalidTokenException`. If this happens, retrieve the rule group again to
    /// get a current copy of it with a current token. Reapply your changes as
    /// needed, then try the operation again using the new token.
    update_token: []const u8,

    pub const json_field_names = .{
        .rule_group = "RuleGroup",
        .rule_group_response = "RuleGroupResponse",
        .update_token = "UpdateToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRuleGroupInput, options: Options) !DescribeRuleGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "networkfirewall");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeRuleGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkfirewall", "Network Firewall", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "NetworkFirewall_20201112.DescribeRuleGroup");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeRuleGroupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeRuleGroupOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InsufficientCapacityException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capacity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourcePolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "LogDestinationPermissionException")) {
        return .{ .arena = arena, .kind = .{ .log_destination_permission_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceOwnerCheckException")) {
        return .{ .arena = arena, .kind = .{ .resource_owner_check_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
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
