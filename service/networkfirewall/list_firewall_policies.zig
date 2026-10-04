const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FirewallPolicyMetadata = @import("firewall_policy_metadata.zig").FirewallPolicyMetadata;

pub const ListFirewallPoliciesInput = struct {
    /// The maximum number of objects that you want Network Firewall to return for
    /// this request. If more
    /// objects are available, in the response, Network Firewall provides a
    /// `NextToken` value that you can use in a subsequent call to get the next
    /// batch of objects.
    max_results: ?i32 = null,

    /// When you request a list of objects with a `MaxResults` setting, if the
    /// number of objects that are still available
    /// for retrieval exceeds the maximum you requested, Network Firewall returns a
    /// `NextToken`
    /// value in the response. To retrieve the next batch of objects, use the token
    /// returned from the prior request in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListFirewallPoliciesOutput = struct {
    /// The metadata for the firewall policies. Depending on your setting for max
    /// results and
    /// the number of firewall policies that you have, this might not be the full
    /// list.
    firewall_policies: ?[]const FirewallPolicyMetadata = null,

    /// When you request a list of objects with a `MaxResults` setting, if the
    /// number of objects that are still available
    /// for retrieval exceeds the maximum you requested, Network Firewall returns a
    /// `NextToken`
    /// value in the response. To retrieve the next batch of objects, use the token
    /// returned from the prior request in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_policies = "FirewallPolicies",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFirewallPoliciesInput, options: CallOptions) !ListFirewallPoliciesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFirewallPoliciesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.ListFirewallPolicies");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFirewallPoliciesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListFirewallPoliciesOutput, body, allocator);
}
