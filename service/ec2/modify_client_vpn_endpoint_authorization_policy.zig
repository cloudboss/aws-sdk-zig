const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClientVpnAuthorizationPolicyShadowMode = @import("client_vpn_authorization_policy_shadow_mode.zig").ClientVpnAuthorizationPolicyShadowMode;
const ClientVpnAuthorizationPolicyStatus = @import("client_vpn_authorization_policy_status.zig").ClientVpnAuthorizationPolicyStatus;

pub const ModifyClientVpnEndpointAuthorizationPolicyInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    /// For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// The ID of the Client VPN endpoint.
    client_vpn_endpoint_id: []const u8,

    /// A brief description of the authorization policy.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The authorization policy document, written in the Cedar policy language.
    /// This parameter is required when you create the authorization policy for a
    /// Client VPN endpoint that does not already have one.
    policy_document: ?[]const u8 = null,

    /// Specifies whether the authorization policy is evaluated in shadow mode.
    /// Possible values include:
    ///
    /// * `enabled` - The authorization policy is evaluated and the results are
    ///   logged, but access is not enforced.
    ///
    /// * `disabled` - The authorization policy is enforced.
    ///
    /// The default value is `disabled`.
    shadow_mode: ?ClientVpnAuthorizationPolicyShadowMode = null,
};

pub const ModifyClientVpnEndpointAuthorizationPolicyOutput = struct {
    /// The current state of the authorization policy.
    status: ?ClientVpnAuthorizationPolicyStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyClientVpnEndpointAuthorizationPolicyInput, options: CallOptions) !ModifyClientVpnEndpointAuthorizationPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyClientVpnEndpointAuthorizationPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyClientVpnEndpointAuthorizationPolicy&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ClientVpnEndpointId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.client_vpn_endpoint_id);
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.policy_document) |v| {
        try body_buf.appendSlice(allocator, "&PolicyDocument=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.shadow_mode) |v| {
        try body_buf.appendSlice(allocator, "&ShadowMode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyClientVpnEndpointAuthorizationPolicyOutput {
    _ = status;
    _ = headers;
    _ = allocator;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyClientVpnEndpointAuthorizationPolicyOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "status")) {
                    result.status = ClientVpnAuthorizationPolicyStatus.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
