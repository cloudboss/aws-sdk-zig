const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InterruptionType = @import("interruption_type.zig").InterruptionType;
const InterruptibleCapacityReservationAllocationStatus = @import("interruptible_capacity_reservation_allocation_status.zig").InterruptibleCapacityReservationAllocationStatus;

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
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInterruptibleCapacityReservationAllocationInput, options: CallOptions) !UpdateInterruptibleCapacityReservationAllocationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateInterruptibleCapacityReservationAllocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=UpdateInterruptibleCapacityReservationAllocation&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&CapacityReservationId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.capacity_reservation_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&TargetInstanceCount=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.target_instance_count}) catch "");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateInterruptibleCapacityReservationAllocationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: UpdateInterruptibleCapacityReservationAllocationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instanceCount")) {
                    result.instance_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "interruptibleCapacityReservationId")) {
                    result.interruptible_capacity_reservation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "interruptionType")) {
                    result.interruption_type = std.meta.stringToEnum(InterruptionType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "sourceCapacityReservationId")) {
                    result.source_capacity_reservation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "status")) {
                    result.status = std.meta.stringToEnum(InterruptibleCapacityReservationAllocationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "targetInstanceCount")) {
                    result.target_instance_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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
