const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const ReservedInstancesListing = @import("reserved_instances_listing.zig").ReservedInstancesListing;
const serde = @import("serde.zig");

/// Describes your account's Reserved Instance listings in the Reserved Instance
/// Marketplace.
///
/// The Reserved Instance Marketplace matches sellers who want to resell
/// Reserved Instance
/// capacity that they no longer need with buyers who want to purchase
/// additional capacity.
/// Reserved Instances bought and sold through the Reserved Instance Marketplace
/// work like any
/// other Reserved Instances.
///
/// As a seller, you choose to list some or all of your Reserved Instances, and
/// you specify
/// the upfront price to receive for them. Your Reserved Instances are then
/// listed in the Reserved
/// Instance Marketplace and are available for purchase.
///
/// As a buyer, you specify the configuration of the Reserved Instance to
/// purchase, and the
/// Marketplace matches what you're searching for with what's available. The
/// Marketplace first
/// sells the lowest priced Reserved Instances to you, and continues to sell
/// available Reserved
/// Instance listings to you until your demand is met. You are charged based on
/// the total price of
/// all of the listings that you purchase.
///
/// For more information, see [Sell in the Reserved Instance
/// Marketplace](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-general.html) in the *Amazon EC2 User Guide*.
///
/// **Note:**
///
/// The order of the elements in the response, including those within nested
/// structures,
/// might vary. Applications should not assume the elements appear in a
/// particular order.
pub const DescribeReservedInstancesListingsInput = struct {
    /// One or more filters.
    ///
    /// * `reserved-instances-id` - The ID of the Reserved Instances.
    ///
    /// * `reserved-instances-listing-id` - The ID of the Reserved Instances
    /// listing.
    ///
    /// * `status` - The status of the Reserved Instance listing (`pending` |
    /// `active` | `cancelled` | `closed`).
    ///
    /// * `status-message` - The reason for the status.
    filters: ?[]const Filter = null,

    /// One or more Reserved Instance IDs.
    reserved_instances_id: ?[]const u8 = null,

    /// One or more Reserved Instance listing IDs.
    reserved_instances_listing_id: ?[]const u8 = null,
};

pub const DescribeReservedInstancesListingsOutput = struct {
    /// Information about the Reserved Instance listing.
    reserved_instances_listings: ?[]const ReservedInstancesListing = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeReservedInstancesListingsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeReservedInstancesListingsInput, options: Options) !DescribeReservedInstancesListingsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeReservedInstancesListingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeReservedInstancesListings&Version=2016-11-15");
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |fv_1| {
                    try appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.item.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.reserved_instances_id) |v| {
        try body_buf.appendSlice(alloc, "&ReservedInstancesId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.reserved_instances_listing_id) |v| {
        try body_buf.appendSlice(alloc, "&ReservedInstancesListingId=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeReservedInstancesListingsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeReservedInstancesListingsOutput = .{};
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
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
