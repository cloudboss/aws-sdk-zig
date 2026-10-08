const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const ReservedDBInstance = @import("reserved_db_instance.zig").ReservedDBInstance;
const serde = @import("serde.zig");

pub const DescribeReservedDBInstancesInput = struct {
    /// The DB instance class filter value. Specify this parameter to show only
    /// those reservations matching the specified DB instances class.
    db_instance_class: ?[]const u8 = null,

    /// The duration filter value, specified in years or seconds. Specify this
    /// parameter to show only reservations for this duration.
    ///
    /// Valid Values: `1 | 3 | 31536000 | 94608000`
    duration: ?[]const u8 = null,

    /// This parameter isn't currently supported.
    filters: ?[]const Filter = null,

    /// The lease identifier filter value. Specify this parameter to show only the
    /// reservation that matches the specified lease ID.
    ///
    /// Amazon Web Services Support might request the lease ID for an issue related
    /// to a reserved DB instance.
    lease_id: ?[]const u8 = null,

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

    /// The product description filter value. Specify this parameter to show only
    /// those reservations matching the specified product description.
    product_description: ?[]const u8 = null,

    /// The reserved DB instance identifier filter value. Specify this parameter to
    /// show only the reservation that matches the specified reservation ID.
    reserved_db_instance_id: ?[]const u8 = null,

    /// The offering identifier filter value. Specify this parameter to show only
    /// purchased reservations matching the specified offering identifier.
    reserved_db_instances_offering_id: ?[]const u8 = null,
};

pub const DescribeReservedDBInstancesOutput = struct {
    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// A list of reserved DB instances.
    reserved_db_instances: ?[]const ReservedDBInstance = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReservedDBInstancesInput, options: CallOptions) !DescribeReservedDBInstancesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReservedDBInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeReservedDBInstances&Version=2014-10-31");
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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.Value.{d}=", .{ n, n_1 }) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                }
            }
        }
    }
    if (input.lease_id) |v| {
        try body_buf.appendSlice(allocator, "&LeaseId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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
    if (input.reserved_db_instance_id) |v| {
        try body_buf.appendSlice(allocator, "&ReservedDBInstanceId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReservedDBInstancesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeReservedDBInstancesResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeReservedDBInstancesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ReservedDBInstances")) {
                    result.reserved_db_instances = try serde.deserializeReservedDBInstanceList(allocator, &reader, "ReservedDBInstance");
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
