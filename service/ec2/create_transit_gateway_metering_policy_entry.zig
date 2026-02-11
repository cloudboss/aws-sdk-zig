const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;
const TransitGatewayMeteringPayerType = @import("transit_gateway_metering_payer_type.zig").TransitGatewayMeteringPayerType;
const TransitGatewayMeteringPolicyEntry = @import("transit_gateway_metering_policy_entry.zig").TransitGatewayMeteringPolicyEntry;

/// Creates an entry in a transit gateway metering policy to define traffic
/// measurement rules.
pub const CreateTransitGatewayMeteringPolicyEntryInput = struct {
    /// The destination CIDR block for traffic matching.
    destination_cidr_block: ?[]const u8 = null,

    /// The destination port range for traffic matching.
    destination_port_range: ?[]const u8 = null,

    /// The ID of the destination transit gateway attachment for traffic matching.
    destination_transit_gateway_attachment_id: ?[]const u8 = null,

    /// The type of the destination transit gateway attachment for traffic matching.
    /// Note that the `tgw-peering` resource type has been deprecated. To configure
    /// metering policies for Connect, use the transport attachment type.
    destination_transit_gateway_attachment_type: ?TransitGatewayAttachmentResourceType = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The Amazon Web Services account ID to which the metered traffic should be
    /// attributed.
    metered_account: TransitGatewayMeteringPayerType,

    /// The rule number for the metering policy entry. Rules are processed in order
    /// from lowest to highest number.
    policy_rule_number: i32,

    /// The protocol for traffic matching (1, 6, 17, etc.).
    protocol: ?[]const u8 = null,

    /// The source CIDR block for traffic matching.
    source_cidr_block: ?[]const u8 = null,

    /// The source port range for traffic matching.
    source_port_range: ?[]const u8 = null,

    /// The ID of the source transit gateway attachment for traffic matching.
    source_transit_gateway_attachment_id: ?[]const u8 = null,

    /// The type of the source transit gateway attachment for traffic matching. Note
    /// that the `tgw-peering` resource type has been deprecated. To configure
    /// metering policies for Connect, use the transport attachment type.
    source_transit_gateway_attachment_type: ?TransitGatewayAttachmentResourceType = null,

    /// The ID of the transit gateway metering policy to add the entry to.
    transit_gateway_metering_policy_id: []const u8,
};

pub const CreateTransitGatewayMeteringPolicyEntryOutput = struct {
    /// Information about the created transit gateway metering policy entry.
    transit_gateway_metering_policy_entry: ?TransitGatewayMeteringPolicyEntry = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateTransitGatewayMeteringPolicyEntryOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateTransitGatewayMeteringPolicyEntryInput, options: Options) !CreateTransitGatewayMeteringPolicyEntryOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateTransitGatewayMeteringPolicyEntryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateTransitGatewayMeteringPolicyEntry&Version=2016-11-15");
    if (input.destination_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&DestinationCidrBlock=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_port_range) |v| {
        try body_buf.appendSlice(alloc, "&DestinationPortRange=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_transit_gateway_attachment_id) |v| {
        try body_buf.appendSlice(alloc, "&DestinationTransitGatewayAttachmentId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_transit_gateway_attachment_type) |v| {
        try body_buf.appendSlice(alloc, "&DestinationTransitGatewayAttachmentType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&MeteredAccount=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.metered_account));
    try body_buf.appendSlice(alloc, "&PolicyRuleNumber=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.policy_rule_number}) catch "");
    if (input.protocol) |v| {
        try body_buf.appendSlice(alloc, "&Protocol=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&SourceCidrBlock=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_port_range) |v| {
        try body_buf.appendSlice(alloc, "&SourcePortRange=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_transit_gateway_attachment_id) |v| {
        try body_buf.appendSlice(alloc, "&SourceTransitGatewayAttachmentId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_transit_gateway_attachment_type) |v| {
        try body_buf.appendSlice(alloc, "&SourceTransitGatewayAttachmentType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&TransitGatewayMeteringPolicyId=");
    try appendUrlEncoded(alloc, &body_buf, input.transit_gateway_metering_policy_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateTransitGatewayMeteringPolicyEntryOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: CreateTransitGatewayMeteringPolicyEntryOutput = .{ .allocator = alloc };

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
