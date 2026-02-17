const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const ModifyCapacityReservationFleetInput = struct {
    /// The ID of the Capacity Reservation Fleet to modify.
    capacity_reservation_fleet_id: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The date and time at which the Capacity Reservation Fleet expires. When the
    /// Capacity
    /// Reservation Fleet expires, its state changes to `expired` and all of the
    /// Capacity Reservations in the Fleet expire.
    ///
    /// The Capacity Reservation Fleet expires within an hour after the specified
    /// time. For
    /// example, if you specify `5/31/2019`, `13:30:55`, the Capacity
    /// Reservation Fleet is guaranteed to expire between `13:30:55` and
    /// `14:30:55` on `5/31/2019`.
    ///
    /// You can't specify **EndDate** and **
    /// RemoveEndDate** in the same request.
    end_date: ?i64 = null,

    /// Indicates whether to remove the end date from the Capacity Reservation
    /// Fleet. If you
    /// remove the end date, the Capacity Reservation Fleet does not expire and it
    /// remains
    /// active until you explicitly cancel it using the
    /// **CancelCapacityReservationFleet** action.
    ///
    /// You can't specify **RemoveEndDate** and ** EndDate** in the same request.
    remove_end_date: ?bool = null,

    /// The total number of capacity units to be reserved by the Capacity
    /// Reservation Fleet.
    /// This value, together with the instance type weights that you assign to each
    /// instance
    /// type used by the Fleet determine the number of instances for which the Fleet
    /// reserves
    /// capacity. Both values are based on units that make sense for your workload.
    /// For more
    /// information, see [Total target
    /// capacity](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/crfleet-concepts.html#target-capacity) in the *Amazon EC2 User Guide*.
    total_target_capacity: ?i32 = null,
};

pub const ModifyCapacityReservationFleetOutput = struct {
    /// Returns `true` if the request succeeds; otherwise, it returns an error.
    @"return": ?bool = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyCapacityReservationFleetOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyCapacityReservationFleetInput, options: Options) !ModifyCapacityReservationFleetOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyCapacityReservationFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyCapacityReservationFleet&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&CapacityReservationFleetId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.capacity_reservation_fleet_id);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.end_date) |v| {
        try body_buf.appendSlice(alloc, "&EndDate=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.remove_end_date) |v| {
        try body_buf.appendSlice(alloc, "&RemoveEndDate=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.total_target_capacity) |v| {
        try body_buf.appendSlice(alloc, "&TotalTargetCapacity=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyCapacityReservationFleetOutput {
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

    var result: ModifyCapacityReservationFleetOutput = .{};
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
