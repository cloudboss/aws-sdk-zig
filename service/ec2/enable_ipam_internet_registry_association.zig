const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpamInternetRegistryAssociation = @import("ipam_internet_registry_association.zig").IpamInternetRegistryAssociation;
const serde = @import("serde.zig");

pub const EnableIpamInternetRegistryAssociationInput = struct {
    /// The child handle for the BPKI certificate hierarchy from the Parent Response
    /// XML.
    child_handle: []const u8,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, the
    /// operation ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the operation, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the IPAM internet registry association to enable.
    ipam_internet_registry_association_id: []const u8,

    /// The parent BPKI Trust Anchor certificate in PEM format from the Parent
    /// Response XML.
    parent_bpki_ta: []const u8,

    /// The parent handle for the BPKI certificate hierarchy from the Parent
    /// Response XML.
    parent_handle: []const u8,

    /// The RPKI version to use from the Parent Response XML.
    rpki_version: []const u8,

    /// The RPKI service URI for the publication point from the Parent Response XML.
    service_uri: []const u8,
};

pub const EnableIpamInternetRegistryAssociationOutput = struct {
    /// Information about the enabled internet registry association.
    ipam_internet_registry_association: ?IpamInternetRegistryAssociation = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableIpamInternetRegistryAssociationInput, options: CallOptions) !EnableIpamInternetRegistryAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableIpamInternetRegistryAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=EnableIpamInternetRegistryAssociation&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&ChildHandle=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.child_handle);
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&IpamInternetRegistryAssociationId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ipam_internet_registry_association_id);
    try body_buf.appendSlice(allocator, "&ParentBpkiTa=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.parent_bpki_ta);
    try body_buf.appendSlice(allocator, "&ParentHandle=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.parent_handle);
    try body_buf.appendSlice(allocator, "&RpkiVersion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.rpki_version);
    try body_buf.appendSlice(allocator, "&ServiceUri=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.service_uri);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableIpamInternetRegistryAssociationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: EnableIpamInternetRegistryAssociationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamInternetRegistryAssociation")) {
                    result.ipam_internet_registry_association = try serde.deserializeIpamInternetRegistryAssociation(allocator, &reader);
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
