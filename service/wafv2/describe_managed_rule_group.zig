const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;
const LabelSummary = @import("label_summary.zig").LabelSummary;
const RuleSummary = @import("rule_summary.zig").RuleSummary;

pub const DescribeManagedRuleGroupInput = struct {
    /// The name of the managed rule group. You use this, along with the vendor
    /// name, to identify the rule group.
    name: []const u8,

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

    /// The name of the managed rule group vendor. You use this, along with the rule
    /// group name, to identify a rule group.
    vendor_name: []const u8,

    /// The version of the rule group. You can only use a version that is not
    /// scheduled for
    /// expiration. If you don't provide this, WAF uses the vendor's default
    /// version.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .scope = "Scope",
        .vendor_name = "VendorName",
        .version_name = "VersionName",
    };
};

pub const DescribeManagedRuleGroupOutput = struct {
    /// The labels that one or more rules in this rule group add to matching web
    /// requests. These labels are defined in the `RuleLabels` for a Rule.
    available_labels: ?[]const LabelSummary = null,

    /// The web ACL capacity units (WCUs) required for this rule group.
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
    capacity: ?i64 = null,

    /// The labels that one or more rules in this rule group match against in label
    /// match statements. These labels are defined in a `LabelMatchStatement`
    /// specification, in the Statement definition of a rule.
    consumed_labels: ?[]const LabelSummary = null,

    /// The label namespace prefix for this rule group. All labels added by rules in
    /// this rule group have this prefix.
    ///
    /// * The syntax for the label namespace prefix for a managed rule group is the
    ///   following:
    ///
    /// `awswaf:managed::`:
    ///
    /// * When a rule with a label matches a web request, WAF adds the fully
    ///   qualified label to the request. A fully qualified label is made up of the
    ///   label namespace from the rule group or web ACL where the rule is defined
    ///   and the label from the rule, separated by a colon:
    ///
    /// `:`
    label_namespace: ?[]const u8 = null,

    rules: ?[]const RuleSummary = null,

    /// The Amazon resource name (ARN) of the Amazon Simple Notification Service SNS
    /// topic that's used to provide notification of changes
    /// to the managed rule group. You can subscribe to the SNS topic to receive
    /// notifications when
    /// the managed rule group is modified, such as for new versions and for version
    /// expiration.
    /// For more information, see the [Amazon Simple Notification Service Developer
    /// Guide](https://docs.aws.amazon.com/sns/latest/dg/welcome.html).
    sns_topic_arn: ?[]const u8 = null,

    /// The managed rule group's version.
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .available_labels = "AvailableLabels",
        .capacity = "Capacity",
        .consumed_labels = "ConsumedLabels",
        .label_namespace = "LabelNamespace",
        .rules = "Rules",
        .sns_topic_arn = "SnsTopicArn",
        .version_name = "VersionName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeManagedRuleGroupInput, options: CallOptions) !DescribeManagedRuleGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeManagedRuleGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.DescribeManagedRuleGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeManagedRuleGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeManagedRuleGroupOutput, body, allocator);
}
