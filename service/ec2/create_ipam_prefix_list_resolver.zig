const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AddressFamily = @import("address_family.zig").AddressFamily;
const IpamPrefixListResolverRuleRequest = @import("ipam_prefix_list_resolver_rule_request.zig").IpamPrefixListResolverRuleRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const IpamPrefixListResolver = @import("ipam_prefix_list_resolver.zig").IpamPrefixListResolver;

/// Creates an IPAM prefix list resolver.
///
/// An IPAM prefix list resolver is a component that manages the synchronization
/// between IPAM's CIDR selection rules and customer-managed prefix lists. It
/// automates connectivity configurations by selecting CIDRs from IPAM's
/// database based on your business logic and synchronizing them with prefix
/// lists used in resources such as VPC route tables and security groups.
///
/// For more information about IPAM prefix list resolver, see [Automate prefix
/// list updates with
/// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/automate-prefix-list-updates.html) in the *Amazon VPC IPAM User Guide*.
pub const CreateIpamPrefixListResolverInput = struct {
    /// The address family for the IPAM prefix list resolver. Valid values are
    /// `ipv4` and `ipv6`. You must create separate resolvers for IPv4 and IPv6
    /// CIDRs as they cannot be mixed in the same resolver.
    address_family: AddressFamily,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description for the IPAM prefix list resolver to help you identify its
    /// purpose and configuration.
    description: ?[]const u8 = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the IPAM that will serve as the source of the IP address database
    /// for CIDR selection. The IPAM must be in the Advanced tier to use this
    /// feature.
    ipam_id: []const u8,

    /// The CIDR selection rules for the resolver.
    ///
    /// CIDR selection rules define the business logic for selecting CIDRs from
    /// IPAM. If a CIDR matches any of the rules, it will be included. If a rule has
    /// multiple conditions, the CIDR has to match every condition of that rule. You
    /// can create a prefix list resolver without any CIDR selection rules, but it
    /// will generate empty versions (containing no CIDRs) until you add rules.
    rules: ?[]const IpamPrefixListResolverRuleRequest = null,

    /// The tags to apply to the IPAM prefix list resolver during creation. Tags
    /// help you organize and manage your Amazon Web Services resources.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateIpamPrefixListResolverOutput = struct {
    /// Information about the IPAM prefix list resolver that was created.
    ipam_prefix_list_resolver: ?IpamPrefixListResolver = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateIpamPrefixListResolverOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateIpamPrefixListResolverInput, options: Options) !CreateIpamPrefixListResolverOutput {
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

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateIpamPrefixListResolverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateIpamPrefixListResolver&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&AddressFamily=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.address_family));
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&IpamId=");
    try appendUrlEncoded(alloc, &body_buf, input.ipam_id);
    if (input.rules) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rules.Rule.{d}.IpamScopeId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipam_scope_id) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rules.Rule.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rules.Rule.{d}.RuleType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try appendUrlEncoded(alloc, &body_buf, @tagName(item.rule_type));
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Rules.Rule.{d}.StaticCidr=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.static_cidr) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateIpamPrefixListResolverOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: CreateIpamPrefixListResolverOutput = .{ .allocator = alloc };

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
