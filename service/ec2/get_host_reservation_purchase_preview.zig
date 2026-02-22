const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;
const Purchase = @import("purchase.zig").Purchase;
const serde = @import("serde.zig");

pub const GetHostReservationPurchasePreviewInput = struct {
    /// The IDs of the Dedicated Hosts with which the reservation is associated.
    host_id_set: []const []const u8,

    /// The offering ID of the reservation.
    offering_id: []const u8,
};

pub const GetHostReservationPurchasePreviewOutput = struct {
    /// The currency in which the `totalUpfrontPrice` and
    /// `totalHourlyPrice` amounts are specified. At this time, the only
    /// supported currency is `USD`.
    currency_code: ?CurrencyCodeValues = null,

    /// The purchase information of the Dedicated Host reservation and the Dedicated
    /// Hosts
    /// associated with it.
    purchase: ?[]const Purchase = null,

    /// The potential total hourly price of the reservation per hour.
    total_hourly_price: ?[]const u8 = null,

    /// The potential total upfront price. This is billed immediately.
    total_upfront_price: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetHostReservationPurchasePreviewOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetHostReservationPurchasePreviewInput, options: Options) !GetHostReservationPurchasePreviewOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetHostReservationPurchasePreviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetHostReservationPurchasePreview&Version=2016-11-15");
    for (input.host_id_set, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&HostIdSet.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
    }
    try body_buf.appendSlice(alloc, "&OfferingId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.offering_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetHostReservationPurchasePreviewOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetHostReservationPurchasePreviewOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "currencyCode")) {
                    result.currency_code = std.meta.stringToEnum(CurrencyCodeValues, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "purchase")) {
                    result.purchase = try serde.deserializePurchaseSet(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "totalHourlyPrice")) {
                    result.total_hourly_price = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "totalUpfrontPrice")) {
                    result.total_upfront_price = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, request_id);
    errdefer alloc.free(owned_request_id);


    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
