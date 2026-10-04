const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateFirewallDeleteProtectionInput = struct {
    /// A flag indicating whether it is possible to delete the firewall. A setting
    /// of `TRUE` indicates
    /// that the firewall is protected against deletion. Use this setting to protect
    /// against
    /// accidentally deleting a firewall that is in use. When you create a firewall,
    /// the operation initializes this flag to `TRUE`.
    delete_protection: ?bool = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_arn: ?[]const u8 = null,

    /// The descriptive name of the firewall. You can't change the name of a
    /// firewall after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_name: ?[]const u8 = null,

    /// An optional token that you can use for optimistic locking. Network Firewall
    /// returns a token to your requests that access the firewall. The token marks
    /// the state of the firewall resource at the time of the request.
    ///
    /// To make an unconditional change to the firewall, omit the token in your
    /// update request. Without the token, Network Firewall performs your updates
    /// regardless of whether the firewall has changed since you last retrieved it.
    ///
    /// To make a conditional change to the firewall, provide the token in your
    /// update request. Network Firewall uses the token to ensure that the firewall
    /// hasn't changed since you last retrieved it. If it has changed, the operation
    /// fails with an `InvalidTokenException`. If this happens, retrieve the
    /// firewall again to get a current copy of it with a new token. Reapply your
    /// changes as needed, then try the operation again using the new token.
    update_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .delete_protection = "DeleteProtection",
        .firewall_arn = "FirewallArn",
        .firewall_name = "FirewallName",
        .update_token = "UpdateToken",
    };
};

pub const UpdateFirewallDeleteProtectionOutput = struct {
    /// A flag indicating whether it is possible to delete the firewall. A setting
    /// of `TRUE` indicates
    /// that the firewall is protected against deletion. Use this setting to protect
    /// against
    /// accidentally deleting a firewall that is in use. When you create a firewall,
    /// the operation initializes this flag to `TRUE`.
    delete_protection: ?bool = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: ?[]const u8 = null,

    /// The descriptive name of the firewall. You can't change the name of a
    /// firewall after you create it.
    firewall_name: ?[]const u8 = null,

    /// An optional token that you can use for optimistic locking. Network Firewall
    /// returns a token to your requests that access the firewall. The token marks
    /// the state of the firewall resource at the time of the request.
    ///
    /// To make an unconditional change to the firewall, omit the token in your
    /// update request. Without the token, Network Firewall performs your updates
    /// regardless of whether the firewall has changed since you last retrieved it.
    ///
    /// To make a conditional change to the firewall, provide the token in your
    /// update request. Network Firewall uses the token to ensure that the firewall
    /// hasn't changed since you last retrieved it. If it has changed, the operation
    /// fails with an `InvalidTokenException`. If this happens, retrieve the
    /// firewall again to get a current copy of it with a new token. Reapply your
    /// changes as needed, then try the operation again using the new token.
    update_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .delete_protection = "DeleteProtection",
        .firewall_arn = "FirewallArn",
        .firewall_name = "FirewallName",
        .update_token = "UpdateToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFirewallDeleteProtectionInput, options: CallOptions) !UpdateFirewallDeleteProtectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFirewallDeleteProtectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.UpdateFirewallDeleteProtection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFirewallDeleteProtectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateFirewallDeleteProtectionOutput, body, allocator);
}
