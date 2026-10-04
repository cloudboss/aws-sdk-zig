const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ReservedDBInstance = @import("reserved_db_instance.zig").ReservedDBInstance;
const serde = @import("serde.zig");

pub const PurchaseReservedDBInstancesOfferingInput = struct {
    /// The number of instances to reserve.
    ///
    /// Default: `1`
    db_instance_count: ?i32 = null,

    /// Customer-specified identifier to track this reservation.
    ///
    /// Example: myreservationID
    reserved_db_instance_id: ?[]const u8 = null,

    /// The ID of the Reserved DB instance offering to purchase.
    ///
    /// Example: 438012d3-4052-4cc7-b2e3-8d3372e0e706
    reserved_db_instances_offering_id: []const u8,

    tags: ?[]const Tag = null,
};

pub const PurchaseReservedDBInstancesOfferingOutput = struct {
    reserved_db_instance: ?ReservedDBInstance = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PurchaseReservedDBInstancesOfferingInput, options: CallOptions) !PurchaseReservedDBInstancesOfferingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PurchaseReservedDBInstancesOfferingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PurchaseReservedDBInstancesOffering&Version=2014-10-31");
    if (input.db_instance_count) |v| {
        try body_buf.appendSlice(allocator, "&DBInstanceCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.reserved_db_instance_id) |v| {
        try body_buf.appendSlice(allocator, "&ReservedDBInstanceId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ReservedDBInstancesOfferingId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.reserved_db_instances_offering_id);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PurchaseReservedDBInstancesOfferingOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PurchaseReservedDBInstancesOfferingResult")) break;
            },
            else => {},
        }
    }

    var result: PurchaseReservedDBInstancesOfferingOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ReservedDBInstance")) {
                    result.reserved_db_instance = try serde.deserializeReservedDBInstance(allocator, &reader);
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
