const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutResourcePolicyInput = struct {
    /// The IAM policy statement that lists the accounts that you want to share your
    /// Network Firewall resources with
    /// and the operations that you want the accounts to be able to perform.
    ///
    /// For a rule group resource, you can specify the following operations in the
    /// Actions section of the statement:
    ///
    /// * network-firewall:CreateFirewallPolicy
    ///
    /// * network-firewall:UpdateFirewallPolicy
    ///
    /// * network-firewall:ListRuleGroups
    ///
    /// For a firewall policy resource, you can specify the following operations in
    /// the Actions section of the statement:
    ///
    /// * network-firewall:AssociateFirewallPolicy
    ///
    /// * network-firewall:ListFirewallPolicies
    ///
    /// For a firewall resource, you can specify the following operations in the
    /// Actions section of the statement:
    ///
    /// * network-firewall:CreateVpcEndpointAssociation
    ///
    /// * network-firewall:DescribeFirewallMetadata
    ///
    /// * network-firewall:ListFirewalls
    ///
    /// In the Resource section of the statement, you specify the ARNs for the
    /// Network Firewall resources that you want to share with the account that you
    /// specified in `Arn`.
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the account that you want to share your
    /// Network Firewall resources with.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};

pub const PutResourcePolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResourcePolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.PutResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
