const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    type: ?RuleGroupType = null,

    pub const json_field_names = .{
        .analyze_rule_group = "AnalyzeRuleGroup",
        .rule_group_arn = "RuleGroupArn",
        .rule_group_name = "RuleGroupName",
        .type = "Type",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRuleGroupInput, options: CallOptions) !DescribeRuleGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-firewall", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRuleGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-firewall", "Network Firewall", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DescribeRuleGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRuleGroupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeRuleGroupOutput, body, allocator);
}
