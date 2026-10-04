const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const ReservedDBInstancesOffering = @import("reserved_db_instances_offering.zig").ReservedDBInstancesOffering;
const serde = @import("serde.zig");

pub const DescribeReservedDBInstancesOfferingsInput = struct {
    /// The DB instance class filter value. Specify this parameter to show only the
    /// available offerings matching the specified DB instance class.
    db_instance_class: ?[]const u8 = null,

    /// Duration filter value, specified in years or seconds. Specify this parameter
    /// to show only reservations for this duration.
    ///
    /// Valid Values: `1 | 3 | 31536000 | 94608000`
    duration: ?[]const u8 = null,

    /// This parameter isn't currently supported.
    filters: ?[]const Filter = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more than the
    /// `MaxRecords` value is available, a pagination token called a marker is
    /// included in the response so you can retrieve the remaining results.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,

    /// Specifies whether to show only those reservations that support Multi-AZ.
    multi_az: ?bool = null,

    /// The offering type filter value. Specify this parameter to show only the
    /// available offerings matching the specified offering type.
    ///
    /// Valid Values: `"Partial Upfront" | "All Upfront" | "No Upfront" `
    offering_type: ?[]const u8 = null,

    /// Product description filter value. Specify this parameter to show only the
    /// available offerings that contain the specified product description.
    ///
    /// The results show offerings that partially match the filter value.
    product_description: ?[]const u8 = null,

    /// The offering identifier filter value. Specify this parameter to show only
    /// the available offering that matches the specified reservation identifier.
    ///
    /// Example: `438012d3-4052-4cc7-b2e3-8d3372e0e706`
    reserved_db_instances_offering_id: ?[]const u8 = null,
};

pub const DescribeReservedDBInstancesOfferingsOutput = struct {
    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// A list of reserved DB instance offerings.
    reserved_db_instances_offerings: ?[]const ReservedDBInstancesOffering = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReservedDBInstancesOfferingsInput, options: CallOptions) !DescribeReservedDBInstancesOfferingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReservedDBInstancesOfferingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeReservedDBInstancesOfferings&Version=2014-10-31");
    if (input.db_instance_class) |v| {
        try body_buf.appendSlice(allocator, "&DBInstanceClass=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.duration) |v| {
        try body_buf.appendSlice(allocator, "&Duration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
            }
            for (item.values, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.Value.{d}=", .{n, n_1}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                }
            }
        }
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.multi_az) |v| {
        try body_buf.appendSlice(allocator, "&MultiAZ=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.offering_type) |v| {
        try body_buf.appendSlice(allocator, "&OfferingType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.product_description) |v| {
        try body_buf.appendSlice(allocator, "&ProductDescription=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.reserved_db_instances_offering_id) |v| {
        try body_buf.appendSlice(allocator, "&ReservedDBInstancesOfferingId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReservedDBInstancesOfferingsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeReservedDBInstancesOfferingsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeReservedDBInstancesOfferingsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedDBInstancesOfferings")) {
                    result.reserved_db_instances_offerings = try serde.deserializeReservedDBInstancesOfferingList(allocator, &reader, "ReservedDBInstancesOffering");
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
