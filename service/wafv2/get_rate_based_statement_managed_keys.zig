const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;
const RateBasedStatementManagedKeysIPSet = @import("rate_based_statement_managed_keys_ip_set.zig").RateBasedStatementManagedKeysIPSet;

pub const GetRateBasedStatementManagedKeysInput = struct {
    /// The name of the rule group reference statement in your web ACL. This is
    /// required only
    /// when you have the rate-based rule nested inside a rule group.
    rule_group_rule_name: ?[]const u8 = null,

    /// The name of the rate-based rule to get the keys for. If you have the rule
    /// defined inside
    /// a rule group that you're using in your web ACL, also provide the name of the
    /// rule group
    /// reference statement in the request parameter `RuleGroupRuleName`.
    rule_name: []const u8,

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

    /// The unique identifier for the web ACL. This ID is returned in the responses
    /// to create and list commands. You provide it to operations like update and
    /// delete.
    web_acl_id: []const u8,

    /// The name of the web ACL. You cannot change the name of a web ACL after you
    /// create it.
    web_acl_name: []const u8,

    pub const json_field_names = .{
        .rule_group_rule_name = "RuleGroupRuleName",
        .rule_name = "RuleName",
        .scope = "Scope",
        .web_acl_id = "WebACLId",
        .web_acl_name = "WebACLName",
    };
};

pub const GetRateBasedStatementManagedKeysOutput = struct {
    /// The keys that are of Internet Protocol version 4 (IPv4).
    managed_keys_ipv4: ?RateBasedStatementManagedKeysIPSet = null,

    /// The keys that are of Internet Protocol version 6 (IPv6).
    managed_keys_ipv6: ?RateBasedStatementManagedKeysIPSet = null,

    pub const json_field_names = .{
        .managed_keys_ipv4 = "ManagedKeysIPV4",
        .managed_keys_ipv6 = "ManagedKeysIPV6",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRateBasedStatementManagedKeysInput, options: CallOptions) !GetRateBasedStatementManagedKeysOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRateBasedStatementManagedKeysInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.GetRateBasedStatementManagedKeys");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRateBasedStatementManagedKeysOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRateBasedStatementManagedKeysOutput, body, allocator);
}
