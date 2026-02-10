const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExcessCapacityTerminationPolicy = @import("excess_capacity_termination_policy.zig").ExcessCapacityTerminationPolicy;
const LaunchTemplateConfig = @import("launch_template_config.zig").LaunchTemplateConfig;

/// Modifies the specified Spot Fleet request.
///
/// You can only modify a Spot Fleet request of type `maintain`.
///
/// While the Spot Fleet request is being modified, it is in the `modifying`
/// state.
///
/// To scale up your Spot Fleet, increase its target capacity. The Spot Fleet
/// launches the
/// additional Spot Instances according to the allocation strategy for the Spot
/// Fleet
/// request. If the allocation strategy is `lowestPrice`, the Spot Fleet
/// launches
/// instances using the Spot Instance pool with the lowest price. If the
/// allocation strategy
/// is `diversified`, the Spot Fleet distributes the instances across the Spot
/// Instance pools. If the allocation strategy is `capacityOptimized`, Spot
/// Fleet
/// launches instances from Spot Instance pools with optimal capacity for the
/// number of instances
/// that are launching.
///
/// To scale down your Spot Fleet, decrease its target capacity. First, the Spot
/// Fleet
/// cancels any open requests that exceed the new target capacity. You can
/// request that the
/// Spot Fleet terminate Spot Instances until the size of the fleet no longer
/// exceeds the
/// new target capacity. If the allocation strategy is `lowestPrice`, the Spot
/// Fleet terminates the instances with the highest price per unit. If the
/// allocation
/// strategy is `capacityOptimized`, the Spot Fleet terminates the instances in
/// the Spot Instance pools that have the least available Spot Instance
/// capacity. If the allocation
/// strategy is `diversified`, the Spot Fleet terminates instances across the
/// Spot Instance pools. Alternatively, you can request that the Spot Fleet keep
/// the fleet
/// at its current size, but not replace any Spot Instances that are interrupted
/// or that you
/// terminate manually.
///
/// If you are finished with your Spot Fleet for now, but will use it again
/// later, you can
/// set the target capacity to 0.
pub const ModifySpotFleetRequestInput = struct {
    /// Reserved.
    context: ?[]const u8 = null,

    /// Indicates whether running instances should be terminated if the target
    /// capacity
    /// of the Spot Fleet request is decreased below the current size of the Spot
    /// Fleet.
    ///
    /// Supported only for fleets of type `maintain`.
    excess_capacity_termination_policy: ?ExcessCapacityTerminationPolicy = null,

    /// The launch template and overrides. You can only use this parameter if you
    /// specified a
    /// launch template (`LaunchTemplateConfigs`) in your Spot Fleet request. If you
    /// specified `LaunchSpecifications` in your Spot Fleet request, then omit this
    /// parameter.
    launch_template_configs: ?[]const LaunchTemplateConfig = null,

    /// The number of On-Demand Instances in the fleet.
    on_demand_target_capacity: ?i32 = null,

    /// The ID of the Spot Fleet request.
    spot_fleet_request_id: []const u8,

    /// The size of the fleet.
    target_capacity: ?i32 = null,
};

pub const ModifySpotFleetRequestOutput = struct {
    /// If the request succeeds, the response returns `true`. If the request fails,
    /// no response is returned, and instead an error message is returned.
    @"return": ?bool = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ModifySpotFleetRequestOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifySpotFleetRequestInput, options: Options) !ModifySpotFleetRequestOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifySpotFleetRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifySpotFleetRequest&Version=2016-11-15");
    if (input.context) |v| {
        try body_buf.appendSlice(alloc, "&Context=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.excess_capacity_termination_policy) |v| {
        try body_buf.appendSlice(alloc, "&ExcessCapacityTerminationPolicy=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.on_demand_target_capacity) |v| {
        try body_buf.appendSlice(alloc, "&OnDemandTargetCapacity=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(alloc, "&SpotFleetRequestId=");
    try appendUrlEncoded(alloc, &body_buf, input.spot_fleet_request_id);
    if (input.target_capacity) |v| {
        try body_buf.appendSlice(alloc, "&TargetCapacity=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ModifySpotFleetRequestOutput {
    _ = status;
    var result: ModifySpotFleetRequestOutput = .{ .allocator = alloc };
    if (findElement(body, "return")) |content| {
        result.@"return" = std.mem.eql(u8, content, "true");
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
