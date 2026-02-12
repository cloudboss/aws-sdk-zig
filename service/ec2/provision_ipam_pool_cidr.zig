const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpamCidrAuthorizationContext = @import("ipam_cidr_authorization_context.zig").IpamCidrAuthorizationContext;
const VerificationMethod = @import("verification_method.zig").VerificationMethod;
const IpamPoolCidr = @import("ipam_pool_cidr.zig").IpamPoolCidr;
const serde = @import("serde.zig");

/// Provision a CIDR to an IPAM pool. You can use this action to provision new
/// CIDRs to a top-level pool or to transfer a CIDR from a top-level pool to a
/// pool within it.
///
/// For more information, see [Provision CIDRs to
/// pools](https://docs.aws.amazon.com/vpc/latest/ipam/prov-cidr-ipam.html) in
/// the *Amazon VPC IPAM User Guide*.
pub const ProvisionIpamPoolCidrInput = struct {
    /// The CIDR you want to assign to the IPAM pool. Either "NetmaskLength" or
    /// "Cidr" is required. This value will be null if you specify "NetmaskLength"
    /// and will be filled in during the provisioning process.
    cidr: ?[]const u8 = null,

    /// A signed document that proves that you are authorized to bring a specified
    /// IP address range to Amazon using BYOIP. This option only applies to IPv4 and
    /// IPv6 pools in the public scope.
    cidr_authorization_context: ?IpamCidrAuthorizationContext = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Verification token ID. This option only applies to IPv4 and IPv6 pools in
    /// the public scope.
    ipam_external_resource_verification_token_id: ?[]const u8 = null,

    /// The ID of the IPAM pool to which you want to assign a CIDR.
    ipam_pool_id: []const u8,

    /// The netmask length of the CIDR you'd like to provision to a pool. Can be
    /// used for provisioning Amazon-provided IPv6 CIDRs to top-level pools and for
    /// provisioning CIDRs to pools with source pools. Cannot be used to provision
    /// BYOIP CIDRs to top-level pools. Either "NetmaskLength" or "Cidr" is
    /// required.
    netmask_length: ?i32 = null,

    /// The method for verifying control of a public IP address range. Defaults to
    /// `remarks-x509` if not specified. This option only applies to IPv4 and IPv6
    /// pools in the public scope.
    verification_method: ?VerificationMethod = null,
};

pub const ProvisionIpamPoolCidrOutput = struct {
    /// Information about the provisioned CIDR.
    ipam_pool_cidr: ?IpamPoolCidr = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ProvisionIpamPoolCidrOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ProvisionIpamPoolCidrInput, options: Options) !ProvisionIpamPoolCidrOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ProvisionIpamPoolCidrInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ProvisionIpamPoolCidr&Version=2016-11-15");
    if (input.cidr) |v| {
        try body_buf.appendSlice(alloc, "&Cidr=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.cidr_authorization_context) |v| {
        if (v.message) |sv| {
            try body_buf.appendSlice(alloc, "&CidrAuthorizationContext.Message=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.signature) |sv| {
            try body_buf.appendSlice(alloc, "&CidrAuthorizationContext.Signature=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ipam_external_resource_verification_token_id) |v| {
        try body_buf.appendSlice(alloc, "&IpamExternalResourceVerificationTokenId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&IpamPoolId=");
    try appendUrlEncoded(alloc, &body_buf, input.ipam_pool_id);
    if (input.netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&NetmaskLength=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.verification_method) |v| {
        try body_buf.appendSlice(alloc, "&VerificationMethod=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ProvisionIpamPoolCidrOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ProvisionIpamPoolCidrOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamPoolCidr")) {
                    result.ipam_pool_cidr = try serde.deserializeIpamPoolCidr(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
