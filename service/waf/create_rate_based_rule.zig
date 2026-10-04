const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RateKey = @import("rate_key.zig").RateKey;
const Tag = @import("tag.zig").Tag;
const RateBasedRule = @import("rate_based_rule.zig").RateBasedRule;

pub const CreateRateBasedRuleInput = struct {
    /// The `ChangeToken` that you used to submit the
    /// `CreateRateBasedRule` request. You can also use this value to query the
    /// status of the request. For more information, see GetChangeTokenStatus.
    change_token: []const u8,

    /// A friendly name or description for the metrics for this `RateBasedRule`.
    /// The name can contain only alphanumeric characters (A-Z, a-z, 0-9), with
    /// maximum length 128 and minimum length one. It can't contain
    /// whitespace or metric names reserved for AWS WAF, including "All" and
    /// "Default_Action." You can't change the name of the metric after you create
    /// the
    /// `RateBasedRule`.
    metric_name: []const u8,

    /// A friendly name or description of the RateBasedRule. You can't
    /// change the name of a `RateBasedRule` after you create it.
    name: []const u8,

    /// The field that AWS WAF uses to determine if requests are likely arriving
    /// from a single
    /// source and thus subject to rate monitoring. The only valid value for
    /// `RateKey`
    /// is `IP`. `IP` indicates that requests that arrive from the same IP
    /// address are subject to the `RateLimit` that is specified in
    /// the `RateBasedRule`.
    rate_key: RateKey,

    /// The maximum number of requests, which have an identical value in the field
    /// that is
    /// specified by `RateKey`, allowed in a five-minute period. If the number of
    /// requests exceeds the `RateLimit` and the other predicates specified in the
    /// rule
    /// are also met, AWS WAF triggers the action that is specified for this rule.
    rate_limit: i64,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
        .metric_name = "MetricName",
        .name = "Name",
        .rate_key = "RateKey",
        .rate_limit = "RateLimit",
        .tags = "Tags",
    };
};

pub const CreateRateBasedRuleOutput = struct {
    /// The `ChangeToken` that you used to submit the
    /// `CreateRateBasedRule` request. You can also use this value to query the
    /// status of the request. For more information, see GetChangeTokenStatus.
    change_token: ?[]const u8 = null,

    /// The RateBasedRule
    /// that is returned in the `CreateRateBasedRule` response.
    rule: ?RateBasedRule = null,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
        .rule = "Rule",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRateBasedRuleInput, options: CallOptions) !CreateRateBasedRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "waf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRateBasedRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("waf", "WAF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20150824.CreateRateBasedRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRateBasedRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRateBasedRuleOutput, body, allocator);
}
