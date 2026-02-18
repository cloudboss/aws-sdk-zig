const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const InterruptionType = @import("interruption_type.zig").InterruptionType;
const InterruptibleCapacityReservationAllocationStatus = @import("interruptible_capacity_reservation_allocation_status.zig").InterruptibleCapacityReservationAllocationStatus;
const serde = @import("serde.zig");

pub const CreateInterruptibleCapacityReservationAllocationInput = struct {
    /// The ID of the source Capacity Reservation from which to create the
    /// interruptible Capacity Reservation. Your Capacity Reservation must be in
    /// active state with no end date set and have available capacity for
    /// allocation.
    capacity_reservation_id: []const u8,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response.
    dry_run: ?bool = null,

    /// The number of instances to allocate from your source reservation. You can
    /// only allocate available instances (also called unused capacity).
    instance_count: i32,

    /// The tags to apply to the interruptible Capacity Reservation during creation.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateInterruptibleCapacityReservationAllocationOutput = struct {
    /// The type of interruption applied to the interruptible reservation.
    interruption_type: ?InterruptionType = null,

    /// The ID of the source Capacity Reservation from which the interruptible
    /// Capacity Reservation was created.
    source_capacity_reservation_id: ?[]const u8 = null,

    /// The current status of the allocation request (creating, active, updating).
    status: ?InterruptibleCapacityReservationAllocationStatus = null,

    /// The number of instances allocated to the interruptible reservation.
    target_instance_count: ?i32 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateInterruptibleCapacityReservationAllocationOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateInterruptibleCapacityReservationAllocationInput, options: Options) !CreateInterruptibleCapacityReservationAllocationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateInterruptibleCapacityReservationAllocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateInterruptibleCapacityReservationAllocation&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&CapacityReservationId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.capacity_reservation_id);
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceCount=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.instance_count}) catch "");
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateInterruptibleCapacityReservationAllocationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateInterruptibleCapacityReservationAllocationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "interruptionType")) {
                    result.interruption_type = std.meta.stringToEnum(InterruptionType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "sourceCapacityReservationId")) {
                    result.source_capacity_reservation_id = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
