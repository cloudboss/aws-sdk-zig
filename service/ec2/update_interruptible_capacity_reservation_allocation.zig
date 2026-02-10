const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InterruptionType = @import("interruption_type.zig").InterruptionType;
const InterruptibleCapacityReservationAllocationStatus = @import("interruptible_capacity_reservation_allocation_status.zig").InterruptibleCapacityReservationAllocationStatus;

/// Modifies the number of instances allocated to an interruptible reservation,
/// allowing you to add more capacity or reclaim capacity to your source
/// Capacity Reservation.
pub const UpdateInterruptibleCapacityReservationAllocationInput = struct {
    /// The ID of the source Capacity Reservation containing the interruptible
    /// allocation to modify.
    capacity_reservation_id: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response.
    dry_run: ?bool = null,

    /// The new number of instances to allocate. Enter a higher number to add more
    /// capacity to share, or a lower number to reclaim capacity to your source
    /// Capacity Reservation.
    target_instance_count: i32,
};

pub const UpdateInterruptibleCapacityReservationAllocationOutput = struct {
    /// The current number of instances allocated to the interruptible reservation.
    instance_count: ?i32 = null,

    /// The ID of the interruptible Capacity Reservation that was modified.
    interruptible_capacity_reservation_id: ?[]const u8 = null,

    /// The interruption type for the interruptible reservation.
    interruption_type: ?InterruptionType = null,

    /// The ID of the source Capacity Reservation to which capacity was reclaimed or
    /// from which capacity was allocated.
    source_capacity_reservation_id: ?[]const u8 = null,

    /// The current status of the allocation (updating during reclamation, active
    /// when complete).
    status: ?InterruptibleCapacityReservationAllocationStatus = null,

    /// The requested number of instances for the interruptible Capacity
    /// Reservation.
    target_instance_count: ?i32 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const UpdateInterruptibleCapacityReservationAllocationOutput) void {
        if (self.interruptible_capacity_reservation_id) |v| {
            self.allocator.free(v);
        }
        if (self.source_capacity_reservation_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: UpdateInterruptibleCapacityReservationAllocationInput, options: Options) !UpdateInterruptibleCapacityReservationAllocationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateInterruptibleCapacityReservationAllocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=UpdateInterruptibleCapacityReservationAllocation&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&CapacityReservationId=");
    try appendUrlEncoded(alloc, &body_buf, input.capacity_reservation_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&TargetInstanceCount=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.target_instance_count}) catch "");

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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !UpdateInterruptibleCapacityReservationAllocationOutput {
    _ = status;
    var result: UpdateInterruptibleCapacityReservationAllocationOutput = .{ .allocator = alloc };
    if (findElement(body, "instanceCount")) |content| {
        result.instance_count = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findElement(body, "interruptibleCapacityReservationId")) |content| {
        result.interruptible_capacity_reservation_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "sourceCapacityReservationId")) |content| {
        result.source_capacity_reservation_id = try alloc.dupe(u8, content);
    }
    if (findElement(body, "targetInstanceCount")) |content| {
        result.target_instance_count = std.fmt.parseInt(i32, content, 10) catch null;
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
