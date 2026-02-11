const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TrafficMirrorPortRangeRequest = @import("traffic_mirror_port_range_request.zig").TrafficMirrorPortRangeRequest;
const TrafficMirrorRuleAction = @import("traffic_mirror_rule_action.zig").TrafficMirrorRuleAction;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TrafficDirection = @import("traffic_direction.zig").TrafficDirection;
const TrafficMirrorFilterRule = @import("traffic_mirror_filter_rule.zig").TrafficMirrorFilterRule;

/// Creates a Traffic Mirror filter rule.
///
/// A Traffic Mirror rule defines the Traffic Mirror source traffic to mirror.
///
/// You need the Traffic Mirror filter ID when you create the rule.
pub const CreateTrafficMirrorFilterRuleInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information, see [How to ensure
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// The description of the Traffic Mirror rule.
    description: ?[]const u8 = null,

    /// The destination CIDR block to assign to the Traffic Mirror rule.
    destination_cidr_block: []const u8,

    /// The destination port range.
    destination_port_range: ?TrafficMirrorPortRangeRequest = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The protocol, for example UDP, to assign to the Traffic Mirror rule.
    ///
    /// For information about the protocol value, see [Protocol
    /// Numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml) on the Internet Assigned Numbers Authority (IANA) website.
    protocol: ?i32 = null,

    /// The action to take on the filtered traffic.
    rule_action: TrafficMirrorRuleAction,

    /// The number of the Traffic Mirror rule. This number must be unique for each
    /// Traffic Mirror rule in a given
    /// direction. The rules are processed in ascending order by rule number.
    rule_number: i32,

    /// The source CIDR block to assign to the Traffic Mirror rule.
    source_cidr_block: []const u8,

    /// The source port range.
    source_port_range: ?TrafficMirrorPortRangeRequest = null,

    /// Traffic Mirroring tags specifications.
    tag_specifications: ?[]const TagSpecification = null,

    /// The type of traffic.
    traffic_direction: TrafficDirection,

    /// The ID of the filter that this rule is associated with.
    traffic_mirror_filter_id: []const u8,
};

pub const CreateTrafficMirrorFilterRuleOutput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information, see [How to ensure
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// The Traffic Mirror rule.
    traffic_mirror_filter_rule: ?TrafficMirrorFilterRule = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateTrafficMirrorFilterRuleOutput) void {
        if (self.client_token) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateTrafficMirrorFilterRuleInput, options: Options) !CreateTrafficMirrorFilterRuleOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateTrafficMirrorFilterRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateTrafficMirrorFilterRule&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&DestinationCidrBlock=");
    try appendUrlEncoded(alloc, &body_buf, input.destination_cidr_block);
    if (input.destination_port_range) |v| {
        if (v.from_port) |sv| {
            try body_buf.appendSlice(alloc, "&DestinationPortRange.FromPort=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.to_port) |sv| {
            try body_buf.appendSlice(alloc, "&DestinationPortRange.ToPort=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.protocol) |v| {
        try body_buf.appendSlice(alloc, "&Protocol=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(alloc, "&RuleAction=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.rule_action));
    try body_buf.appendSlice(alloc, "&RuleNumber=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.rule_number}) catch "");
    try body_buf.appendSlice(alloc, "&SourceCidrBlock=");
    try appendUrlEncoded(alloc, &body_buf, input.source_cidr_block);
    if (input.source_port_range) |v| {
        if (v.from_port) |sv| {
            try body_buf.appendSlice(alloc, "&SourcePortRange.FromPort=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.to_port) |sv| {
            try body_buf.appendSlice(alloc, "&SourcePortRange.ToPort=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
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
    try body_buf.appendSlice(alloc, "&TrafficDirection=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.traffic_direction));
    try body_buf.appendSlice(alloc, "&TrafficMirrorFilterId=");
    try appendUrlEncoded(alloc, &body_buf, input.traffic_mirror_filter_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateTrafficMirrorFilterRuleOutput {
    _ = status;
    _ = headers;
    var result: CreateTrafficMirrorFilterRuleOutput = .{ .allocator = alloc };
    if (findElement(body, "clientToken")) |content| {
        result.client_token = try alloc.dupe(u8, content);
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
