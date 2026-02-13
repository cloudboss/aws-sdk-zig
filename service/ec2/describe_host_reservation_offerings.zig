const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const HostOffering = @import("host_offering.zig").HostOffering;
const serde = @import("serde.zig");

/// Describes the Dedicated Host reservations that are available to purchase.
///
/// The results describe all of the Dedicated Host reservation offerings,
/// including
/// offerings that might not match the instance family and Region of your
/// Dedicated Hosts.
/// When purchasing an offering, ensure that the instance family and Region of
/// the offering
/// matches that of the Dedicated Hosts with which it is to be associated. For
/// more
/// information about supported instance types, see [Dedicated
/// Hosts](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-overview.html)
/// in the *Amazon EC2 User Guide*.
pub const DescribeHostReservationOfferingsInput = struct {
    /// The filters.
    ///
    /// * `instance-family` - The instance family of the offering (for example,
    /// `m4`).
    ///
    /// * `payment-option` - The payment option (`NoUpfront` |
    /// `PartialUpfront` | `AllUpfront`).
    filter: ?[]const Filter = null,

    /// This is the maximum duration of the reservation to purchase, specified in
    /// seconds.
    /// Reservations are available in one-year and three-year terms. The number of
    /// seconds
    /// specified must be the number of seconds in a year (365x24x60x60) times one
    /// of the
    /// supported durations (1 or 3). For example, specify 94608000 for three years.
    max_duration: ?i32 = null,

    /// The maximum number of results to return for the request in a single page.
    /// The remaining results can be seen by sending another request with the
    /// returned `nextToken` value. This value can be between 5 and 500. If
    /// `maxResults` is given a larger value than 500, you receive an error.
    max_results: ?i32 = null,

    /// This is the minimum duration of the reservation you'd like to purchase,
    /// specified in
    /// seconds. Reservations are available in one-year and three-year terms. The
    /// number of
    /// seconds specified must be the number of seconds in a year (365x24x60x60)
    /// times one of
    /// the supported durations (1 or 3). For example, specify 31536000 for one
    /// year.
    min_duration: ?i32 = null,

    /// The token to use to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// The ID of the reservation offering.
    offering_id: ?[]const u8 = null,
};

pub const DescribeHostReservationOfferingsOutput = struct {
    /// The token to use to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// Information about the offerings.
    offering_set: ?[]const HostOffering = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeHostReservationOfferingsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeHostReservationOfferingsInput, options: Options) !DescribeHostReservationOfferingsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeHostReservationOfferingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeHostReservationOfferings&Version=2016-11-15");
    if (input.filter) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Values.item.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.max_duration) |v| {
        try body_buf.appendSlice(alloc, "&MaxDuration=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.min_duration) |v| {
        try body_buf.appendSlice(alloc, "&MinDuration=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.offering_id) |v| {
        try body_buf.appendSlice(alloc, "&OfferingId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeHostReservationOfferingsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeHostReservationOfferingsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "offeringSet")) {
                    result.offering_set = try serde.deserializeHostOfferingSet(&reader, alloc, "item");
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
