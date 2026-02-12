const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FleetExcessCapacityTerminationPolicy = @import("fleet_excess_capacity_termination_policy.zig").FleetExcessCapacityTerminationPolicy;
const FleetLaunchTemplateConfigRequest = @import("fleet_launch_template_config_request.zig").FleetLaunchTemplateConfigRequest;
const TargetCapacitySpecificationRequest = @import("target_capacity_specification_request.zig").TargetCapacitySpecificationRequest;
const serde = @import("serde.zig");

/// Modifies the specified EC2 Fleet.
///
/// You can only modify an EC2 Fleet request of type `maintain`.
///
/// While the EC2 Fleet is being modified, it is in the `modifying` state.
///
/// To scale up your EC2 Fleet, increase its target capacity. The EC2 Fleet
/// launches the additional
/// Spot Instances according to the allocation strategy for the EC2 Fleet
/// request. If the allocation
/// strategy is `lowest-price`, the EC2 Fleet launches instances using the Spot
/// Instance
/// pool with the lowest price. If the allocation strategy is `diversified`, the
/// EC2 Fleet distributes the instances across the Spot Instance pools. If the
/// allocation strategy
/// is `capacity-optimized`, EC2 Fleet launches instances from Spot Instance
/// pools with optimal
/// capacity for the number of instances that are launching.
///
/// To scale down your EC2 Fleet, decrease its target capacity. First, the EC2
/// Fleet cancels any open
/// requests that exceed the new target capacity. You can request that the EC2
/// Fleet terminate Spot
/// Instances until the size of the fleet no longer exceeds the new target
/// capacity. If the
/// allocation strategy is `lowest-price`, the EC2 Fleet terminates the
/// instances with
/// the highest price per unit. If the allocation strategy is
/// `capacity-optimized`,
/// the EC2 Fleet terminates the instances in the Spot Instance pools that have
/// the least available
/// Spot Instance capacity. If the allocation strategy is `diversified`, the EC2
/// Fleet terminates
/// instances across the Spot Instance pools. Alternatively, you can request
/// that the EC2 Fleet keep
/// the fleet at its current size, but not replace any Spot Instances that are
/// interrupted or
/// that you terminate manually.
///
/// If you are finished with your EC2 Fleet for now, but will use it again
/// later, you can set the
/// target capacity to 0.
pub const ModifyFleetInput = struct {
    /// Reserved.
    context: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Indicates whether running instances should be terminated if the total target
    /// capacity of
    /// the EC2 Fleet is decreased below the current size of the EC2 Fleet.
    ///
    /// Supported only for fleets of type `maintain`.
    excess_capacity_termination_policy: ?FleetExcessCapacityTerminationPolicy = null,

    /// The ID of the EC2 Fleet.
    fleet_id: []const u8,

    /// The launch template and overrides.
    launch_template_configs: ?[]const FleetLaunchTemplateConfigRequest = null,

    /// The size of the EC2 Fleet.
    target_capacity_specification: ?TargetCapacitySpecificationRequest = null,
};

pub const ModifyFleetOutput = struct {
    /// If the request succeeds, the response returns `true`. If the request fails,
    /// no response is returned, and instead an error message is returned.
    @"return": ?bool = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyFleetOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyFleetInput, options: Options) !ModifyFleetOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyFleet&Version=2016-11-15");
    if (input.context) |v| {
        try body_buf.appendSlice(alloc, "&Context=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.excess_capacity_termination_policy) |v| {
        try body_buf.appendSlice(alloc, "&ExcessCapacityTerminationPolicy=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&FleetId=");
    try appendUrlEncoded(alloc, &body_buf, input.fleet_id);
    if (input.target_capacity_specification) |v| {
        if (v.default_target_capacity_type) |sv| {
            try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.DefaultTargetCapacityType=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.on_demand_target_capacity) |sv| {
            try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.OnDemandTargetCapacity=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.spot_target_capacity) |sv| {
            try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.SpotTargetCapacity=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.target_capacity_unit_type) |sv| {
            try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.TargetCapacityUnitType=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        try body_buf.appendSlice(alloc, "&TargetCapacitySpecification.TotalTargetCapacity=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v.total_target_capacity}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyFleetOutput {
    _ = status;
    _ = headers;
    _ = alloc;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyFleetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
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
