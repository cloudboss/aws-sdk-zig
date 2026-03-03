const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PriceScheduleSpecification = @import("price_schedule_specification.zig").PriceScheduleSpecification;
const ReservedInstancesListing = @import("reserved_instances_listing.zig").ReservedInstancesListing;
const serde = @import("serde.zig");

pub const CreateReservedInstancesListingInput = struct {
    /// Unique, case-sensitive identifier you provide to ensure idempotency of your
    /// listings. This
    /// helps avoid duplicate listings. For more information, see [Ensuring
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: []const u8,

    /// The number of instances that are a part of a Reserved Instance account to be
    /// listed in the
    /// Reserved Instance Marketplace. This number should be less than or equal to
    /// the instance count
    /// associated with the Reserved Instance ID specified in this call.
    instance_count: i32,

    /// A list specifying the price of the Standard Reserved Instance for each month
    /// remaining in
    /// the Reserved Instance term.
    price_schedules: []const PriceScheduleSpecification,

    /// The ID of the active Standard Reserved Instance.
    reserved_instances_id: []const u8,
};

pub const CreateReservedInstancesListingOutput = struct {
    /// Information about the Standard Reserved Instance listing.
    reserved_instances_listings: ?[]const ReservedInstancesListing = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReservedInstancesListingInput, options: CallOptions) !CreateReservedInstancesListingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReservedInstancesListingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateReservedInstancesListing&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&ClientToken=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.client_token);
    try body_buf.appendSlice(allocator, "&InstanceCount=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.instance_count}) catch "");
    for (input.price_schedules, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PriceSchedules.item.{d}.CurrencyCode=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            if (item.currency_code) |fv_1| {
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PriceSchedules.item.{d}.Price=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            if (item.price) |fv_1| {
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PriceSchedules.item.{d}.Term=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            if (item.term) |fv_1| {
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
            }
        }
    }
    try body_buf.appendSlice(allocator, "&ReservedInstancesId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.reserved_instances_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReservedInstancesListingOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateReservedInstancesListingOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "reservedInstancesListingsSet")) {
                    result.reserved_instances_listings = try serde.deserializeReservedInstancesListingList(allocator, &reader, "item");
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
