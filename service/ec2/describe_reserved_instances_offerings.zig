const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const Tenancy = @import("tenancy.zig").Tenancy;
const InstanceType = @import("instance_type.zig").InstanceType;
const OfferingClassType = @import("offering_class_type.zig").OfferingClassType;
const OfferingTypeValues = @import("offering_type_values.zig").OfferingTypeValues;
const RIProductDescription = @import("ri_product_description.zig").RIProductDescription;
const ReservedInstancesOffering = @import("reserved_instances_offering.zig").ReservedInstancesOffering;
const serde = @import("serde.zig");

/// Describes Reserved Instance offerings that are available for purchase. With
/// Reserved
/// Instances, you purchase the right to launch instances for a period of time.
/// During that time
/// period, you do not receive insufficient capacity errors, and you pay a lower
/// usage rate than
/// the rate charged for On-Demand instances for the actual time used.
///
/// If you have listed your own Reserved Instances for sale in the Reserved
/// Instance
/// Marketplace, they will be excluded from these results. This is to ensure
/// that you do not
/// purchase your own Reserved Instances.
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
pub const DescribeReservedInstancesOfferingsInput = struct {
    /// The Availability Zone in which the Reserved Instance can be used.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` can be specified,
    /// but not both.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` can be specified,
    /// but not both.
    availability_zone_id: ?[]const u8 = null,

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
    ///   can be
    /// used.
    ///
    /// * `availability-zone-id` - The ID of the Availability Zone where the
    ///   Reserved
    /// Instance can be used.
    ///
    /// * `duration` - The duration of the Reserved Instance (for example, one year
    ///   or
    /// three years), in seconds (`31536000` | `94608000`).
    ///
    /// * `fixed-price` - The purchase price of the Reserved Instance (for example,
    /// 9800.0).
    ///
    /// * `instance-type` - The instance type that is covered by the reservation.
    ///
    /// * `marketplace` - Set to `true` to show only Reserved Instance
    /// Marketplace offerings. When this filter is not used, which is the default
    /// behavior, all
    /// offerings from both Amazon Web Services and the Reserved Instance
    /// Marketplace are listed.
    ///
    /// * `product-description` - The Reserved Instance product platform description
    /// (`Linux/UNIX` | `Linux with SQL Server Standard` | `Linux
    /// with SQL Server Web` | `Linux with SQL Server Enterprise` | `SUSE
    /// Linux` | `Red Hat Enterprise Linux` | `Red Hat Enterprise Linux
    /// with HA` | `Windows` | `Windows with SQL Server Standard` |
    /// `Windows with SQL Server Web` | `Windows with SQL Server
    /// Enterprise`).
    ///
    /// * `reserved-instances-offering-id` - The Reserved Instances offering ID.
    ///
    /// * `scope` - The scope of the Reserved Instance (`Availability Zone` or
    /// `Region`).
    ///
    /// * `usage-price` - The usage price of the Reserved Instance, per hour (for
    /// example, 0.84).
    filters: ?[]const Filter = null,

    /// Include Reserved Instance Marketplace offerings in the response.
    include_marketplace: ?bool = null,

    /// The tenancy of the instances covered by the reservation. A Reserved Instance
    /// with a
    /// tenancy of `dedicated` is applied to instances that run in a VPC on
    /// single-tenant
    /// hardware (i.e., Dedicated Instances).
    ///
    /// **Important:** The `host` value cannot be used with
    /// this parameter. Use the `default` or `dedicated` values only.
    ///
    /// Default: `default`
    instance_tenancy: ?Tenancy = null,

    /// The instance type that the reservation will cover (for example, `m1.small`).
    /// For more information, see [Amazon EC2 instance
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in the
    /// *Amazon EC2 User Guide*.
    instance_type: ?InstanceType = null,

    /// The maximum duration (in seconds) to filter when searching for offerings.
    ///
    /// Default: 94608000 (3 years)
    max_duration: ?i64 = null,

    /// The maximum number of instances to filter when searching for offerings.
    ///
    /// Default: 20
    max_instance_count: ?i32 = null,

    /// The maximum number of results to return for the request in a single page.
    /// The remaining
    /// results of the initial request can be seen by sending another request with
    /// the returned
    /// `NextToken` value. The maximum is 100.
    ///
    /// Default: 100
    max_results: ?i32 = null,

    /// The minimum duration (in seconds) to filter when searching for offerings.
    ///
    /// Default: 2592000 (1 month)
    min_duration: ?i64 = null,

    /// The token to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// The offering class of the Reserved Instance. Can be `standard` or
    /// `convertible`.
    offering_class: ?OfferingClassType = null,

    /// The Reserved Instance offering type. If you are using tools that predate the
    /// 2011-11-01
    /// API version, you only have access to the `Medium Utilization` Reserved
    /// Instance
    /// offering type.
    offering_type: ?OfferingTypeValues = null,

    /// The Reserved Instance product platform description. Instances that include
    /// `(Amazon
    /// VPC)` in the description are for use with Amazon VPC.
    product_description: ?RIProductDescription = null,

    /// One or more Reserved Instances offering IDs.
    reserved_instances_offering_ids: ?[]const []const u8 = null,
};

pub const DescribeReservedInstancesOfferingsOutput = struct {
    /// The token to use to retrieve the next page of results. This value is `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// A list of Reserved Instances offerings.
    reserved_instances_offerings: ?[]const ReservedInstancesOffering = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeReservedInstancesOfferingsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeReservedInstancesOfferingsInput, options: Options) !DescribeReservedInstancesOfferingsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeReservedInstancesOfferingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeReservedInstancesOfferings&Version=2016-11-15");
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZone=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.availability_zone_id) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZoneId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.include_marketplace) |v| {
        try body_buf.appendSlice(alloc, "&IncludeMarketplace=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_tenancy) |v| {
        try body_buf.appendSlice(alloc, "&InstanceTenancy=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.instance_type) |v| {
        try body_buf.appendSlice(alloc, "&InstanceType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.max_duration) |v| {
        try body_buf.appendSlice(alloc, "&MaxDuration=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.max_instance_count) |v| {
        try body_buf.appendSlice(alloc, "&MaxInstanceCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.min_duration) |v| {
        try body_buf.appendSlice(alloc, "&MinDuration=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.offering_class) |v| {
        try body_buf.appendSlice(alloc, "&OfferingClass=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.offering_type) |v| {
        try body_buf.appendSlice(alloc, "&OfferingType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.product_description) |v| {
        try body_buf.appendSlice(alloc, "&ProductDescription=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.reserved_instances_offering_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReservedInstancesOfferingIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeReservedInstancesOfferingsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeReservedInstancesOfferingsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "reservedInstancesOfferingsSet")) {
                    result.reserved_instances_offerings = try serde.deserializeReservedInstancesOfferingList(&reader, alloc, "item");
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
