const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;
const TransitGatewayMeteringPayerType = @import("transit_gateway_metering_payer_type.zig").TransitGatewayMeteringPayerType;
const TransitGatewayMeteringPolicyEntry = @import("transit_gateway_metering_policy_entry.zig").TransitGatewayMeteringPolicyEntry;
const serde = @import("serde.zig");

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTransitGatewayMeteringPolicyEntryInput, options: Options) !CreateTransitGatewayMeteringPolicyEntryOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateTransitGatewayMeteringPolicyEntryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateTransitGatewayMeteringPolicyEntry&Version=2016-11-15");
    if (input.destination_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&DestinationCidrBlock=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_port_range) |v| {
        try body_buf.appendSlice(alloc, "&DestinationPortRange=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_transit_gateway_attachment_id) |v| {
        try body_buf.appendSlice(alloc, "&DestinationTransitGatewayAttachmentId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_transit_gateway_attachment_type) |v| {
        try body_buf.appendSlice(alloc, "&DestinationTransitGatewayAttachmentType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&MeteredAccount=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.metered_account));
    try body_buf.appendSlice(alloc, "&PolicyRuleNumber=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.policy_rule_number}) catch "");
    if (input.protocol) |v| {
        try body_buf.appendSlice(alloc, "&Protocol=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&SourceCidrBlock=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_port_range) |v| {
        try body_buf.appendSlice(alloc, "&SourcePortRange=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_transit_gateway_attachment_id) |v| {
        try body_buf.appendSlice(alloc, "&SourceTransitGatewayAttachmentId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_transit_gateway_attachment_type) |v| {
        try body_buf.appendSlice(alloc, "&SourceTransitGatewayAttachmentType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&TransitGatewayMeteringPolicyId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.transit_gateway_metering_policy_id);

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
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateTransitGatewayMeteringPolicyEntryOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "transitGatewayMeteringPolicyEntry")) {
                    result.transit_gateway_metering_policy_entry = try serde.deserializeTransitGatewayMeteringPolicyEntry(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
