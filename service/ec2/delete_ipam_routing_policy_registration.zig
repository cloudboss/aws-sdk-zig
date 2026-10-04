const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpamRoutingPolicyRegistrationDelta = @import("ipam_routing_policy_registration_delta.zig").IpamRoutingPolicyRegistrationDelta;
const serde = @import("serde.zig");

pub const DeleteIpamRoutingPolicyRegistrationInput = struct {
    /// The IP address prefix in CIDR notation identifying the routing policy
    /// registration to delete.
    cidr: []const u8,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, the
    /// operation ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the operation, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Forces the deletion even if it conflicts with an announced route. Default:
    /// `false`.
    force: ?bool = null,

    /// The ID of the IPAM internet registry association.
    ipam_internet_registry_association_id: []const u8,
};

pub const DeleteIpamRoutingPolicyRegistrationOutput = struct {
    /// Information about the routing policy registration delta created by this
    /// deletion.
    ipam_routing_policy_registration_delta: ?IpamRoutingPolicyRegistrationDelta = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteIpamRoutingPolicyRegistrationInput, options: CallOptions) !DeleteIpamRoutingPolicyRegistrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteIpamRoutingPolicyRegistrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteIpamRoutingPolicyRegistration&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&Cidr=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cidr);
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.force) |v| {
        try body_buf.appendSlice(allocator, "&Force=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&IpamInternetRegistryAssociationId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ipam_internet_registry_association_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteIpamRoutingPolicyRegistrationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DeleteIpamRoutingPolicyRegistrationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamRoutingPolicyRegistrationDelta")) {
                    result.ipam_routing_policy_registration_delta = try serde.deserializeIpamRoutingPolicyRegistrationDelta(allocator, &reader);
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
