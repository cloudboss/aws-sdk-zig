const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FirewallPolicyResponse = @import("firewall_policy_response.zig").FirewallPolicyResponse;

pub const DeleteFirewallPolicyInput = struct {
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

pub const DeleteFirewallPolicyOutput = struct {
    /// The object containing the definition of the FirewallPolicyResponse
    /// that you asked to delete.
    firewall_policy_response: ?FirewallPolicyResponse = null,

    pub const json_field_names = .{
        .firewall_policy_response = "FirewallPolicyResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFirewallPolicyInput, options: CallOptions) !DeleteFirewallPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFirewallPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DeleteFirewallPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFirewallPolicyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteFirewallPolicyOutput, body, allocator);
}
