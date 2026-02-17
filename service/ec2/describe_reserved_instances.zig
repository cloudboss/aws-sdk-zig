const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const OfferingClassType = @import("offering_class_type.zig").OfferingClassType;
const OfferingTypeValues = @import("offering_type_values.zig").OfferingTypeValues;
const ReservedInstances = @import("reserved_instances.zig").ReservedInstances;
const serde = @import("serde.zig");

pub const DescribeReservedInstancesInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making
    /// the request, and provides an error response. If you have the required
    /// permissions, the error
    /// response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// One or more filters.
    ///
    /// * `availability-zone` - The Availability Zone where the Reserved Instance
    ///   can
    /// be used.
    ///
    /// * `availability-zone-id` - The ID of the Availability Zone where the
    ///   Reserved
    /// Instance can be used.
    ///
    /// * `duration` - The duration of the Reserved Instance (one year or three
    /// years), in seconds (`31536000` | `94608000`).
    ///
    /// * `end` - The time when the Reserved Instance expires (for example,
    /// 2015-08-07T11:54:42.000Z).
    ///
    /// * `fixed-price` - The purchase price of the Reserved Instance (for example,
    /// 9800.0).
    ///
    /// * `instance-type` - The instance type that is covered by the
    /// reservation.
    ///
    /// * `scope` - The scope of the Reserved Instance (`Region` or
    /// `Availability Zone`).
    ///
    /// * `product-description` - The Reserved Instance product platform description
    /// (`Linux/UNIX` | `Linux with SQL Server Standard` | `Linux
    /// with SQL Server Web` | `Linux with SQL Server Enterprise` | `SUSE
    /// Linux` | `Red Hat Enterprise Linux` | `Red Hat Enterprise Linux
    /// with HA` | `Windows` | `Windows with SQL Server Standard` |
    /// `Windows with SQL Server Web` | `Windows with SQL Server
    /// Enterprise`).
    ///
    /// * `reserved-instances-id` - The ID of the Reserved Instance.
    ///
    /// * `start` - The time at which the Reserved Instance purchase request was
    /// placed (for example, 2014-08-07T11:54:42.000Z).
    ///
    /// * `state` - The state of the Reserved Instance (`payment-pending`
    /// | `active` | `payment-failed` | `retired`).
    ///
    /// * `tag:` - The key/value combination of a tag assigned to the resource. Use
    ///   the tag key in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    ///
    /// * `tag-key` - The key of a tag assigned to the resource. Use this filter to
    ///   find all resources assigned a tag with a specific key, regardless of the
    ///   tag value.
    ///
    /// * `usage-price` - The usage price of the Reserved Instance, per hour (for
    /// example, 0.84).
    filters: ?[]const Filter = null,

    /// Describes whether the Reserved Instance is Standard or Convertible.
    offering_class: ?OfferingClassType = null,

    /// The Reserved Instance offering type. If you are using tools that predate the
    /// 2011-11-01
    /// API version, you only have access to the `Medium Utilization` Reserved
    /// Instance
    /// offering type.
    offering_type: ?OfferingTypeValues = null,

    /// One or more Reserved Instance IDs.
    ///
    /// Default: Describes all your Reserved Instances, or only those otherwise
    /// specified.
    reserved_instances_ids: ?[]const []const u8 = null,
};

pub const DescribeReservedInstancesOutput = struct {
    /// A list of Reserved Instances.
    reserved_instances: ?[]const ReservedInstances = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeReservedInstancesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeReservedInstancesInput, options: Options) !DescribeReservedInstancesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeReservedInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeReservedInstances&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.item.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.offering_class) |v| {
        try body_buf.appendSlice(alloc, "&OfferingClass=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.offering_type) |v| {
        try body_buf.appendSlice(alloc, "&OfferingType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.reserved_instances_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReservedInstancesIds.ReservedInstancesId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeReservedInstancesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeReservedInstancesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "reservedInstancesSet")) {
                    result.reserved_instances = try serde.deserializeReservedInstancesList(&reader, alloc, "item");
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
