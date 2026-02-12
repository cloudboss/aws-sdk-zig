const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SpotFleetRequestConfigData = @import("spot_fleet_request_config_data.zig").SpotFleetRequestConfigData;
const serde = @import("serde.zig");

/// Creates a Spot Fleet request.
///
/// The Spot Fleet request specifies the total target capacity and the On-Demand
/// target
/// capacity. Amazon EC2 calculates the difference between the total capacity
/// and On-Demand
/// capacity, and launches the difference as Spot capacity.
///
/// You can submit a single request that includes multiple launch specifications
/// that vary
/// by instance type, AMI, Availability Zone, or subnet.
///
/// By default, the Spot Fleet requests Spot Instances in the Spot Instance pool
/// where the
/// price per unit is the lowest. Each launch specification can include its own
/// instance
/// weighting that reflects the value of the instance type to your application
/// workload.
///
/// Alternatively, you can specify that the Spot Fleet distribute the target
/// capacity
/// across the Spot pools included in its launch specifications. By ensuring
/// that the Spot
/// Instances in your Spot Fleet are in different Spot pools, you can improve
/// the
/// availability of your fleet.
///
/// You can specify tags for the Spot Fleet request and instances launched by
/// the fleet.
/// You cannot tag other resource types in a Spot Fleet request because only the
/// `spot-fleet-request` and `instance` resource types are
/// supported.
///
/// For more information, see [Spot Fleet
/// requests](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-requests.html)
/// in the *Amazon EC2 User Guide*.
///
/// **Important:**
///
/// We strongly discourage using the RequestSpotFleet API because it is a legacy
/// API with no planned investment. For options for requesting Spot Instances,
/// see
/// [Which
/// is the best Spot request method to
/// use?](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-best-practices.html#which-spot-request-method-to-use) in the
/// *Amazon EC2 User Guide*.
pub const RequestSpotFleetInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The configuration for the Spot Fleet request.
    spot_fleet_request_config: SpotFleetRequestConfigData,
};

pub const RequestSpotFleetOutput = struct {
    /// The ID of the Spot Fleet request.
    spot_fleet_request_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *RequestSpotFleetOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RequestSpotFleetInput, options: Options) !RequestSpotFleetOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: RequestSpotFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=RequestSpotFleet&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.spot_fleet_request_config.allocation_strategy) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.AllocationStrategy=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.client_token) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.context) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.Context=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.excess_capacity_termination_policy) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.ExcessCapacityTerminationPolicy=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.fulfilled_capacity) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.FulfilledCapacity=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.IamFleetRole=");
    try appendUrlEncoded(alloc, &body_buf, input.spot_fleet_request_config.iam_fleet_role);
    if (input.spot_fleet_request_config.instance_interruption_behavior) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.InstanceInterruptionBehavior=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.instance_pools_to_use_count) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.InstancePoolsToUseCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.spot_fleet_request_config.on_demand_allocation_strategy) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.OnDemandAllocationStrategy=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.on_demand_fulfilled_capacity) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.OnDemandFulfilledCapacity=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.on_demand_max_total_price) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.OnDemandMaxTotalPrice=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.on_demand_target_capacity) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.OnDemandTargetCapacity=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.spot_fleet_request_config.replace_unhealthy_instances) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.ReplaceUnhealthyInstances=");
        try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.spot_fleet_request_config.spot_max_total_price) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.SpotMaxTotalPrice=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.spot_fleet_request_config.spot_price) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.SpotPrice=");
        try appendUrlEncoded(alloc, &body_buf, sv);
    }
    try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.TargetCapacity=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.spot_fleet_request_config.target_capacity}) catch "");
    if (input.spot_fleet_request_config.target_capacity_unit_type) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.TargetCapacityUnitType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.terminate_instances_with_expiration) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.TerminateInstancesWithExpiration=");
        try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.spot_fleet_request_config.@"type") |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.Type=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
    }
    if (input.spot_fleet_request_config.valid_from) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.ValidFrom=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
    }
    if (input.spot_fleet_request_config.valid_until) |sv| {
        try body_buf.appendSlice(alloc, "&SpotFleetRequestConfig.ValidUntil=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RequestSpotFleetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: RequestSpotFleetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "spotFleetRequestId")) {
                    result.spot_fleet_request_id = try alloc.dupe(u8, try reader.readElementText());
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
