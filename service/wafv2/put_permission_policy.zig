const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutPermissionPolicyInput = struct {
    /// The policy to attach to the specified rule group.
    ///
    /// The policy specifications must conform to the following:
    ///
    /// * The policy must be composed using IAM Policy version 2012-10-17.
    ///
    /// * The policy must include specifications for `Effect`, `Action`, and
    ///   `Principal`.
    ///
    /// * `Effect` must specify `Allow`.
    ///
    /// * `Action` must specify `wafv2:CreateWebACL`, `wafv2:UpdateWebACL`, and
    /// `wafv2:PutFirewallManagerRuleGroups` and may optionally specify
    /// `wafv2:GetRuleGroup`.
    /// WAF rejects any extra actions or wildcard actions in the policy.
    ///
    /// * The policy must not include a `Resource` parameter.
    ///
    /// For more information, see [IAM
    /// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html).
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the RuleGroup to which you want to
    /// attach the policy.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};

pub const PutPermissionPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutPermissionPolicyInput, options: CallOptions) !PutPermissionPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutPermissionPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.PutPermissionPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutPermissionPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
