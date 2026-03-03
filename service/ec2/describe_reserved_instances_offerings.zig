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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReservedInstancesOfferingsInput, options: Options) !DescribeReservedInstancesOfferingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReservedInstancesOfferingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DescribeReservedInstancesOfferings&Version=2016-11-15");
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.availability_zone_id) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZoneId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Values.item.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.include_marketplace) |v| {
        try body_buf.appendSlice(allocator, "&IncludeMarketplace=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_tenancy) |v| {
        try body_buf.appendSlice(allocator, "&InstanceTenancy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.instance_type) |v| {
        try body_buf.appendSlice(allocator, "&InstanceType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.max_duration) |v| {
        try body_buf.appendSlice(allocator, "&MaxDuration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.max_instance_count) |v| {
        try body_buf.appendSlice(allocator, "&MaxInstanceCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.min_duration) |v| {
        try body_buf.appendSlice(allocator, "&MinDuration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.offering_class) |v| {
        try body_buf.appendSlice(allocator, "&OfferingClass=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.offering_type) |v| {
        try body_buf.appendSlice(allocator, "&OfferingType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.product_description) |v| {
        try body_buf.appendSlice(allocator, "&ProductDescription=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.reserved_instances_offering_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ReservedInstancesOfferingId.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReservedInstancesOfferingsOutput {
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
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "reservedInstancesOfferingsSet")) {
                    result.reserved_instances_offerings = try serde.deserializeReservedInstancesOfferingList(allocator, &reader, "item");
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
