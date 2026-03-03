const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TrafficMirrorPortRangeRequest = @import("traffic_mirror_port_range_request.zig").TrafficMirrorPortRangeRequest;
const TrafficMirrorRuleAction = @import("traffic_mirror_rule_action.zig").TrafficMirrorRuleAction;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const TrafficDirection = @import("traffic_direction.zig").TrafficDirection;
const TrafficMirrorFilterRule = @import("traffic_mirror_filter_rule.zig").TrafficMirrorFilterRule;
const serde = @import("serde.zig");

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrafficMirrorFilterRuleInput, options: Options) !CreateTrafficMirrorFilterRuleOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrafficMirrorFilterRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateTrafficMirrorFilterRule&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DestinationCidrBlock=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.destination_cidr_block);
    if (input.destination_port_range) |v| {
        if (v.from_port) |sv| {
            try body_buf.appendSlice(allocator, "&DestinationPortRange.FromPort=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.to_port) |sv| {
            try body_buf.appendSlice(allocator, "&DestinationPortRange.ToPort=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.protocol) |v| {
        try body_buf.appendSlice(allocator, "&Protocol=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&RuleAction=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(input.rule_action));
    try body_buf.appendSlice(allocator, "&RuleNumber=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.rule_number}) catch "");
    try body_buf.appendSlice(allocator, "&SourceCidrBlock=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_cidr_block);
    if (input.source_port_range) |v| {
        if (v.from_port) |sv| {
            try body_buf.appendSlice(allocator, "&SourcePortRange.FromPort=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.to_port) |sv| {
            try body_buf.appendSlice(allocator, "&SourcePortRange.ToPort=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&TrafficDirection=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(input.traffic_direction));
    try body_buf.appendSlice(allocator, "&TrafficMirrorFilterId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.traffic_mirror_filter_id);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrafficMirrorFilterRuleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateTrafficMirrorFilterRuleOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "clientToken")) {
                    result.client_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "trafficMirrorFilterRule")) {
                    result.traffic_mirror_filter_rule = try serde.deserializeTrafficMirrorFilterRule(allocator, &reader);
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
