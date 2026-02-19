const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateReservedInstancesListingOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateReservedInstancesListingInput, options: Options) !CreateReservedInstancesListingOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateReservedInstancesListingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateReservedInstancesListing&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&ClientToken=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.client_token);
    try body_buf.appendSlice(alloc, "&InstanceCount=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.instance_count}) catch "");
    for (input.price_schedules, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PriceSchedules.item.{d}.CurrencyCode=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.currency_code) |fv_1| {
                try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PriceSchedules.item.{d}.Price=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.price) |fv_1| {
                try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PriceSchedules.item.{d}.Term=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            if (item.term) |fv_1| {
                try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
            }
        }
    }
    try body_buf.appendSlice(alloc, "&ReservedInstancesId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.reserved_instances_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateReservedInstancesListingOutput {
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
                    result.reserved_instances_listings = try serde.deserializeReservedInstancesListingList(&reader, alloc, "item");
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
