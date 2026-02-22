const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TrafficMirrorPortRangeRequest = @import("traffic_mirror_port_range_request.zig").TrafficMirrorPortRangeRequest;
const TrafficMirrorFilterRuleField = @import("traffic_mirror_filter_rule_field.zig").TrafficMirrorFilterRuleField;
const TrafficMirrorRuleAction = @import("traffic_mirror_rule_action.zig").TrafficMirrorRuleAction;
const TrafficDirection = @import("traffic_direction.zig").TrafficDirection;
const TrafficMirrorFilterRule = @import("traffic_mirror_filter_rule.zig").TrafficMirrorFilterRule;
const serde = @import("serde.zig");

pub const ModifyTrafficMirrorFilterRuleInput = struct {
    /// The description to assign to the Traffic Mirror rule.
    description: ?[]const u8 = null,

    /// The destination CIDR block to assign to the Traffic Mirror rule.
    destination_cidr_block: ?[]const u8 = null,

    /// The destination ports that are associated with the Traffic Mirror rule.
    destination_port_range: ?TrafficMirrorPortRangeRequest = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The protocol, for example TCP, to assign to the Traffic Mirror rule.
    protocol: ?i32 = null,

    /// The properties that you want to remove from the Traffic Mirror filter rule.
    ///
    /// When you remove a property from a Traffic Mirror filter rule, the property
    /// is set to the default.
    remove_fields: ?[]const TrafficMirrorFilterRuleField = null,

    /// The action to assign to the rule.
    rule_action: ?TrafficMirrorRuleAction = null,

    /// The number of the Traffic Mirror rule. This number must be unique for each
    /// Traffic Mirror rule in a given
    /// direction. The rules are processed in ascending order by rule number.
    rule_number: ?i32 = null,

    /// The source CIDR block to assign to the Traffic Mirror rule.
    source_cidr_block: ?[]const u8 = null,

    /// The port range to assign to the Traffic Mirror rule.
    source_port_range: ?TrafficMirrorPortRangeRequest = null,

    /// The type of traffic to assign to the rule.
    traffic_direction: ?TrafficDirection = null,

    /// The ID of the Traffic Mirror rule.
    traffic_mirror_filter_rule_id: []const u8,
};

pub const ModifyTrafficMirrorFilterRuleOutput = struct {
    /// Tags are not returned for ModifyTrafficMirrorFilterRule.
    ///
    /// A Traffic Mirror rule.
    traffic_mirror_filter_rule: ?TrafficMirrorFilterRule = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyTrafficMirrorFilterRuleOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyTrafficMirrorFilterRuleInput, options: Options) !ModifyTrafficMirrorFilterRuleOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyTrafficMirrorFilterRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyTrafficMirrorFilterRule&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&DestinationCidrBlock=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_port_range) |v| {
        if (v.from_port) |sv| {
            try body_buf.appendSlice(alloc, "&DestinationPortRange.FromPort=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.to_port) |sv| {
            try body_buf.appendSlice(alloc, "&DestinationPortRange.ToPort=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.protocol) |v| {
        try body_buf.appendSlice(alloc, "&Protocol=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.remove_fields) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveField.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.rule_action) |v| {
        try body_buf.appendSlice(alloc, "&RuleAction=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.rule_number) |v| {
        try body_buf.appendSlice(alloc, "&RuleNumber=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.source_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&SourceCidrBlock=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_port_range) |v| {
        if (v.from_port) |sv| {
            try body_buf.appendSlice(alloc, "&SourcePortRange.FromPort=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.to_port) |sv| {
            try body_buf.appendSlice(alloc, "&SourcePortRange.ToPort=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.traffic_direction) |v| {
        try body_buf.appendSlice(alloc, "&TrafficDirection=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&TrafficMirrorFilterRuleId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.traffic_mirror_filter_rule_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyTrafficMirrorFilterRuleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyTrafficMirrorFilterRuleOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "trafficMirrorFilterRule")) {
                    result.traffic_mirror_filter_rule = try serde.deserializeTrafficMirrorFilterRule(&reader, alloc);
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
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, request_id);
    errdefer alloc.free(owned_request_id);


    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
