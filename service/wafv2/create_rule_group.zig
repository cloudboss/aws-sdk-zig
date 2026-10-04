const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomResponseBody = @import("custom_response_body.zig").CustomResponseBody;
const MonetizationConfig = @import("monetization_config.zig").MonetizationConfig;
const Rule = @import("rule.zig").Rule;
const Scope = @import("scope.zig").Scope;
const Tag = @import("tag.zig").Tag;
const VisibilityConfig = @import("visibility_config.zig").VisibilityConfig;
const RuleGroupSummary = @import("rule_group_summary.zig").RuleGroupSummary;

pub const CreateRuleGroupInput = struct {
    /// The web ACL capacity units (WCUs) required for this rule group.
    ///
    /// When you create your own rule group, you define this, and you cannot change
    /// it after creation.
    /// When you add or modify the rules in a rule group, WAF enforces this limit.
    /// You can check the capacity
    /// for a set of rules using CheckCapacity.
    ///
    /// WAF uses WCUs to calculate and control the operating
    /// resources that are used to run your rules, rule groups, and web ACLs. WAF
    /// calculates capacity differently for each rule type, to reflect the relative
    /// cost of each rule.
    /// Simple rules that cost little to run use fewer WCUs than more complex rules
    /// that use more processing power.
    /// Rule group capacity is fixed at creation, which helps users plan their
    /// web ACL WCU usage when they use a rule group. For more information, see [WAF
    /// web ACL capacity units
    /// (WCU)](https://docs.aws.amazon.com/waf/latest/developerguide/aws-waf-capacity-units.html)
    /// in the *WAF Developer Guide*.
    capacity: i64,

    /// A map of custom response keys and content bodies. When you create a rule
    /// with a block action, you can send a custom response to the web request. You
    /// define these for the rule group, and then use them in the rules that you
    /// define in the rule group.
    ///
    /// For information about customizing web requests and responses,
    /// see [Customizing web requests and responses in
    /// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-custom-request-response.html)
    /// in the *WAF Developer Guide*.
    ///
    /// For information about the limits on count and size for custom request and
    /// response settings, see [WAF
    /// quotas](https://docs.aws.amazon.com/waf/latest/developerguide/limits.html)
    /// in the *WAF Developer Guide*.
    custom_response_bodies: ?[]const aws.map.MapEntry(CustomResponseBody) = null,

    /// A description of the rule group that helps with identification.
    description: ?[]const u8 = null,

    /// The monetization configuration for the rule group. Provide this when any
    /// rule in the rule group uses the `Monetize` action.
    monetization_config: ?MonetizationConfig = null,

    /// The name of the rule group. You cannot change the name of a rule group after
    /// you create it.
    name: []const u8,

    /// The Rule statements used to identify the web requests that you
    /// want to manage. Each rule includes one top-level statement that WAF uses to
    /// identify matching
    /// web requests, and parameters that govern how WAF handles them.
    rules: ?[]const Rule = null,

    /// Specifies whether this is for a global resource type, such as a Amazon
    /// CloudFront distribution. For an Amplify application, use `CLOUDFRONT`.
    ///
    /// To work with CloudFront, you must also specify the Region US East (N.
    /// Virginia) as follows:
    ///
    /// * CLI - Specify the Region when you use the CloudFront scope:
    ///   `--scope=CLOUDFRONT --region=us-east-1`.
    ///
    /// * API and SDKs - For all calls, use the Region endpoint us-east-1.
    scope: Scope,

    /// An array of key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    /// Defines and enables Amazon CloudWatch metrics and web request sample
    /// collection.
    visibility_config: VisibilityConfig,

    pub const json_field_names = .{
        .capacity = "Capacity",
        .custom_response_bodies = "CustomResponseBodies",
        .description = "Description",
        .monetization_config = "MonetizationConfig",
        .name = "Name",
        .rules = "Rules",
        .scope = "Scope",
        .tags = "Tags",
        .visibility_config = "VisibilityConfig",
    };
};

pub const CreateRuleGroupOutput = struct {
    /// High-level information about a RuleGroup, returned by operations like create
    /// and list. This provides information like the ID, that you can use to
    /// retrieve and manage a `RuleGroup`, and the ARN, that you provide to the
    /// RuleGroupReferenceStatement to use the rule group in a Rule.
    summary: ?RuleGroupSummary = null,

    pub const json_field_names = .{
        .summary = "Summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRuleGroupInput, options: CallOptions) !CreateRuleGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wafv2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRuleGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.CreateRuleGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRuleGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRuleGroupOutput, body, allocator);
}
