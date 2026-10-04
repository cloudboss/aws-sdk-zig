const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleGroupType = @import("rule_group_type.zig").RuleGroupType;
const StatefulRuleOptions = @import("stateful_rule_options.zig").StatefulRuleOptions;

pub const DescribeRuleGroupMetadataInput = struct {
    /// The descriptive name of the rule group. You can't change the name of a rule
    /// group after you create it.
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
        .rule_group_arn = "RuleGroupArn",
        .rule_group_name = "RuleGroupName",
        .@"type" = "Type",
    };
};

pub const DescribeRuleGroupMetadataOutput = struct {
    /// The maximum operating resources that this rule group can use. Rule group
    /// capacity is fixed at creation.
    /// When you update a rule group, you are limited to this capacity. When you
    /// reference a rule group
    /// from a firewall policy, Network Firewall reserves this capacity for the rule
    /// group.
    ///
    /// You can retrieve the capacity that would be required for a rule group before
    /// you create the rule group by calling
    /// CreateRuleGroup with `DryRun` set to `TRUE`.
    capacity: ?i32 = null,

    /// Returns the metadata objects for the specified rule group.
    description: ?[]const u8 = null,

    /// A timestamp indicating when the rule group was last modified.
    last_modified_time: ?i64 = null,

    /// The display name of the product listing for this rule group.
    listing_name: ?[]const u8 = null,

    /// The unique identifier for the product listing associated with this rule
    /// group.
    product_id: ?[]const u8 = null,

    /// The descriptive name of the rule group. You can't change the name of a rule
    /// group after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    rule_group_arn: []const u8,

    /// The descriptive name of the rule group. You can't change the name of a rule
    /// group after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    rule_group_name: []const u8,

    stateful_rule_options: ?StatefulRuleOptions = null,

    /// Indicates whether the rule group is stateless or stateful. If the rule group
    /// is stateless, it contains
    /// stateless rules. If it is stateful, it contains stateful rules.
    ///
    /// This setting is required for requests that do not include the
    /// `RuleGroupARN`.
    @"type": ?RuleGroupType = null,

    /// The name of the Amazon Web Services Marketplace vendor that provides this
    /// rule group.
    vendor_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity = "Capacity",
        .description = "Description",
        .last_modified_time = "LastModifiedTime",
        .listing_name = "ListingName",
        .product_id = "ProductId",
        .rule_group_arn = "RuleGroupArn",
        .rule_group_name = "RuleGroupName",
        .stateful_rule_options = "StatefulRuleOptions",
        .@"type" = "Type",
        .vendor_name = "VendorName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRuleGroupMetadataInput, options: CallOptions) !DescribeRuleGroupMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRuleGroupMetadataInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DescribeRuleGroupMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRuleGroupMetadataOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeRuleGroupMetadataOutput, body, allocator);
}
