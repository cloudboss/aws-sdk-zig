const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleGroupType = @import("rule_group_type.zig").RuleGroupType;
const Summary = @import("summary.zig").Summary;

pub const DescribeRuleGroupSummaryInput = struct {
    /// Required. The Amazon Resource Name (ARN) of the rule group.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    rule_group_arn: ?[]const u8 = null,

    /// The descriptive name of the rule group. You can't change the name of a rule
    /// group after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    rule_group_name: ?[]const u8 = null,

    /// The type of rule group you want a summary for. This is a required field.
    ///
    /// Valid value: `STATEFUL`
    ///
    /// Note that `STATELESS` exists but is not currently supported. If you provide
    /// `STATELESS`, an exception is returned.
    type: ?RuleGroupType = null,

    pub const json_field_names = .{
        .rule_group_arn = "RuleGroupArn",
        .rule_group_name = "RuleGroupName",
        .type = "Type",
    };
};

pub const DescribeRuleGroupSummaryOutput = struct {
    /// A description of the rule group.
    description: ?[]const u8 = null,

    /// The descriptive name of the rule group. You can't change the name of a rule
    /// group after you create it.
    rule_group_name: []const u8,

    /// A complex type that contains rule information based on the rule group's
    /// configured summary settings. The content varies depending on the fields that
    /// you specified to extract in your SummaryConfiguration. When you haven't
    /// configured any summary settings, this returns an empty array. The response
    /// might include:
    ///
    /// * Rule identifiers
    ///
    /// * Rule descriptions
    ///
    /// * Any metadata fields that you specified in your SummaryConfiguration
    summary: ?Summary = null,

    pub const json_field_names = .{
        .description = "Description",
        .rule_group_name = "RuleGroupName",
        .summary = "Summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRuleGroupSummaryInput, options: CallOptions) !DescribeRuleGroupSummaryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRuleGroupSummaryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DescribeRuleGroupSummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRuleGroupSummaryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeRuleGroupSummaryOutput, body, allocator);
}
