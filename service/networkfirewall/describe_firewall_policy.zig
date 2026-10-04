const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FirewallPolicy = @import("firewall_policy.zig").FirewallPolicy;
const FirewallPolicyResponse = @import("firewall_policy_response.zig").FirewallPolicyResponse;

pub const DescribeFirewallPolicyInput = struct {
    /// The Amazon Resource Name (ARN) of the firewall policy.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_policy_arn: ?[]const u8 = null,

    /// The descriptive name of the firewall policy. You can't change the name of a
    /// firewall policy after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_policy_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_policy_arn = "FirewallPolicyArn",
        .firewall_policy_name = "FirewallPolicyName",
    };
};

pub const DescribeFirewallPolicyOutput = struct {
    /// The policy for the specified firewall policy.
    firewall_policy: ?FirewallPolicy = null,

    /// The high-level properties of a firewall policy. This, along with the
    /// FirewallPolicy, define the policy. You can retrieve all objects for a
    /// firewall policy by calling DescribeFirewallPolicy.
    firewall_policy_response: ?FirewallPolicyResponse = null,

    /// A token used for optimistic locking. Network Firewall returns a token to
    /// your requests that access the firewall policy. The token marks the state of
    /// the policy resource at the time of the request.
    ///
    /// To make changes to the policy, you provide the token in your request.
    /// Network Firewall uses the token to ensure that the policy hasn't changed
    /// since you last retrieved it. If it has changed, the operation fails with an
    /// `InvalidTokenException`. If this happens, retrieve the firewall policy again
    /// to get a current copy of it with current token. Reapply your changes as
    /// needed, then try the operation again using the new token.
    update_token: []const u8,

    pub const json_field_names = .{
        .firewall_policy = "FirewallPolicy",
        .firewall_policy_response = "FirewallPolicyResponse",
        .update_token = "UpdateToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFirewallPolicyInput, options: CallOptions) !DescribeFirewallPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFirewallPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DescribeFirewallPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFirewallPolicyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeFirewallPolicyOutput, body, allocator);
}
