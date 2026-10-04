const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MinimumLoadBalancerCapacity = @import("minimum_load_balancer_capacity.zig").MinimumLoadBalancerCapacity;
const ZonalCapacityReservationState = @import("zonal_capacity_reservation_state.zig").ZonalCapacityReservationState;
const serde = @import("serde.zig");

pub const ModifyCapacityReservationInput = struct {
    /// The Amazon Resource Name (ARN) of the load balancer.
    load_balancer_arn: []const u8,

    /// The minimum load balancer capacity reserved.
    minimum_load_balancer_capacity: ?MinimumLoadBalancerCapacity = null,

    /// Resets the capacity reservation.
    reset_capacity_reservation: ?bool = null,
};

pub const ModifyCapacityReservationOutput = struct {
    /// The state of the capacity reservation.
    capacity_reservation_state: ?[]const ZonalCapacityReservationState = null,

    /// The amount of daily capacity decreases remaining.
    decrease_requests_remaining: ?i32 = null,

    /// The last time the capacity reservation was modified.
    last_modified_time: ?i64 = null,

    /// The requested minimum capacity reservation for the load balancer
    minimum_load_balancer_capacity: ?MinimumLoadBalancerCapacity = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyCapacityReservationInput, options: CallOptions) !ModifyCapacityReservationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticloadbalancing", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyCapacityReservationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyCapacityReservation&Version=2015-12-01");
    try body_buf.appendSlice(allocator, "&LoadBalancerArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.load_balancer_arn);
    if (input.minimum_load_balancer_capacity) |v| {
        if (v.capacity_units) |sv| {
            try body_buf.appendSlice(allocator, "&MinimumLoadBalancerCapacity.CapacityUnits=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
    }
    if (input.reset_capacity_reservation) |v| {
        try body_buf.appendSlice(allocator, "&ResetCapacityReservation=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyCapacityReservationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyCapacityReservationResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyCapacityReservationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CapacityReservationState")) {
                    result.capacity_reservation_state = try serde.deserializeZonalCapacityReservationStates(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "DecreaseRequestsRemaining")) {
                    result.decrease_requests_remaining = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LastModifiedTime")) {
                    result.last_modified_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MinimumLoadBalancerCapacity")) {
                    result.minimum_load_balancer_capacity = try serde.deserializeMinimumLoadBalancerCapacity(allocator, &reader);
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
