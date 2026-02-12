const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpamPolicyAllocationRuleRequest = @import("ipam_policy_allocation_rule_request.zig").IpamPolicyAllocationRuleRequest;
const IpamPolicyResourceType = @import("ipam_policy_resource_type.zig").IpamPolicyResourceType;
const IpamPolicyDocument = @import("ipam_policy_document.zig").IpamPolicyDocument;
const serde = @import("serde.zig");

/// Modifies the allocation rules in an IPAM policy.
///
/// An IPAM policy is a set of rules that define how public IPv4 addresses from
/// IPAM pools are allocated to Amazon Web Services resources. Each rule maps an
/// Amazon Web Services service to IPAM pools that the service will use to get
/// IP addresses. A single policy can have multiple rules and be applied to
/// multiple Amazon Web Services Regions. If the IPAM pool run out of addresses
/// then the services fallback to Amazon-provided IP addresses. A policy can be
/// applied to an individual Amazon Web Services account or an entity within
/// Amazon Web Services Organizations.
///
/// Allocation rules are optional configurations within an IPAM policy that map
/// Amazon Web Services resource types to specific IPAM pools. If no rules are
/// defined, the resource types default to using Amazon-provided IP addresses.
pub const ModifyIpamPolicyAllocationRulesInput = struct {
    /// The new allocation rules to apply to the IPAM policy.
    ///
    /// Allocation rules are optional configurations within an IPAM policy that map
    /// Amazon Web Services resource types to specific IPAM pools. If no rules are
    /// defined, the resource types default to using Amazon-provided IP addresses.
    allocation_rules: ?[]const IpamPolicyAllocationRuleRequest = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the IPAM policy whose allocation rules you want to modify.
    ipam_policy_id: []const u8,

    /// The locale for which to modify the allocation rules.
    locale: []const u8,

    /// The resource type for which to modify the allocation rules.
    ///
    /// The Amazon Web Services service or resource type that can use IP addresses
    /// through IPAM policies. Supported services and resource types include:
    ///
    /// * Elastic IP addresses
    resource_type: IpamPolicyResourceType,
};

pub const ModifyIpamPolicyAllocationRulesOutput = struct {
    /// The modified IPAM policy containing the updated allocation rules.
    ipam_policy_document: ?IpamPolicyDocument = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyIpamPolicyAllocationRulesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyIpamPolicyAllocationRulesInput, options: Options) !ModifyIpamPolicyAllocationRulesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyIpamPolicyAllocationRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyIpamPolicyAllocationRules&Version=2016-11-15");
    if (input.allocation_rules) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AllocationRules.item.{d}.SourceIpamPoolId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.source_ipam_pool_id) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&IpamPolicyId=");
    try appendUrlEncoded(alloc, &body_buf, input.ipam_policy_id);
    try body_buf.appendSlice(alloc, "&Locale=");
    try appendUrlEncoded(alloc, &body_buf, input.locale);
    try body_buf.appendSlice(alloc, "&ResourceType=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.resource_type));

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyIpamPolicyAllocationRulesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyIpamPolicyAllocationRulesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamPolicyDocument")) {
                    result.ipam_policy_document = try serde.deserializeIpamPolicyDocument(&reader, alloc);
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
