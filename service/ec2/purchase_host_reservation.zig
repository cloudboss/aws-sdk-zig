const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const Purchase = @import("purchase.zig").Purchase;
const serde = @import("serde.zig");

/// Purchase a reservation with configurations that match those of your
/// Dedicated Host.
/// You must have active Dedicated Hosts in your account before you purchase a
/// reservation.
/// This action results in the specified reservation being purchased and charged
/// to your
/// account.
pub const PurchaseHostReservationInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information, see [Ensuring
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The currency in which the `totalUpfrontPrice`, `LimitPrice`, and
    /// `totalHourlyPrice` amounts are specified. At this time, the only
    /// supported currency is `USD`.
    currency_code: ?CurrencyCodeValues = null,

    /// The IDs of the Dedicated Hosts with which the reservation will be
    /// associated.
    host_id_set: []const []const u8,

    /// The specified limit is checked against the total upfront cost of the
    /// reservation
    /// (calculated as the offering's upfront cost multiplied by the host count). If
    /// the total
    /// upfront cost is greater than the specified price limit, the request fails.
    /// This is used
    /// to ensure that the purchase does not exceed the expected upfront cost of the
    /// purchase.
    /// At this time, the only supported currency is `USD`. For example, to indicate
    /// a limit price of USD 100, specify 100.00.
    limit_price: ?[]const u8 = null,

    /// The ID of the offering.
    offering_id: []const u8,

    /// The tags to apply to the Dedicated Host Reservation during purchase.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const PurchaseHostReservationOutput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information, see [Ensuring
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The currency in which the `totalUpfrontPrice` and
    /// `totalHourlyPrice` amounts are specified. At this time, the only
    /// supported currency is `USD`.
    currency_code: ?CurrencyCodeValues = null,

    /// Describes the details of the purchase.
    purchase: ?[]const Purchase = null,

    /// The total hourly price of the reservation calculated per hour.
    total_hourly_price: ?[]const u8 = null,

    /// The total amount charged to your account when you purchase the reservation.
    total_upfront_price: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *PurchaseHostReservationOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: PurchaseHostReservationInput, options: Options) !PurchaseHostReservationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: PurchaseHostReservationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=PurchaseHostReservation&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.currency_code) |v| {
        try body_buf.appendSlice(alloc, "&CurrencyCode=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    for (input.host_id_set, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&HostIdSet.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.limit_price) |v| {
        try body_buf.appendSlice(alloc, "&LimitPrice=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&OfferingId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.offering_id);
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PurchaseHostReservationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: PurchaseHostReservationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "clientToken")) {
                    result.client_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "currencyCode")) {
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
