const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const InstanceType = @import("instance_type.zig").InstanceType;
const SpotPrice = @import("spot_price.zig").SpotPrice;
const serde = @import("serde.zig");

pub const DescribeSpotPriceHistoryInput = struct {
    /// Filters the results by the specified Availability Zone.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` can be specified, but not
    /// both
    availability_zone: ?[]const u8 = null,

    /// Filters the results by the specified ID of the Availability Zone.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` can be specified, but not
    /// both
    availability_zone_id: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The date and time, up to the current date, from which to stop retrieving the
    /// price
    /// history data, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    end_time: ?i64 = null,

    /// The filters.
    ///
    /// * `availability-zone` - The Availability Zone for which prices should
    /// be returned.
    ///
    /// * `availability-zone-id` - The ID of the Availability Zone for which
    /// prices should be returned.
    ///
    /// * `instance-type` - The type of instance (for example,
    /// `m3.medium`).
    ///
    /// * `product-description` - The product description for the Spot price
    /// (`Linux/UNIX` | `Red Hat Enterprise Linux` |
    /// `SUSE Linux` | `Windows` | `Linux/UNIX (Amazon
    /// VPC)` | `Red Hat Enterprise Linux (Amazon VPC)` |
    /// `SUSE Linux (Amazon VPC)` | `Windows (Amazon
    /// VPC)`).
    ///
    /// * `spot-price` - The Spot price. The value must match exactly (or use
    /// wildcards; greater than or less than comparison is not supported).
    ///
    /// * `timestamp` - The time stamp of the Spot price history, in UTC format
    /// (for example, *ddd MMM dd
    /// HH*:*mm*:*ss* UTC
    /// *YYYY*). You can use wildcards (`*` and
    /// `?`). Greater than or less than comparison is not
    /// supported.
    filters: ?[]const Filter = null,

    /// Filters the results by the specified instance types.
    instance_types: ?[]const InstanceType = null,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,

    /// Filters the results by the specified basic product descriptions.
    product_descriptions: ?[]const []const u8 = null,

    /// The date and time, up to the past 90 days, from which to start retrieving
    /// the price
    /// history data, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    start_time: ?i64 = null,
};

pub const DescribeSpotPriceHistoryOutput = struct {
    /// The token to include in another request to get the next page of items. This
    /// value is
    /// an empty string (`""`) or `null` when there are no more items to return.
    next_token: ?[]const u8 = null,

    /// The historical Spot prices.
    spot_price_history: ?[]const SpotPrice = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeSpotPriceHistoryOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeSpotPriceHistoryInput, options: Options) !DescribeSpotPriceHistoryOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeSpotPriceHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeSpotPriceHistory&Version=2016-11-15");
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZone=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.availability_zone_id) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZoneId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.end_time) |v| {
        try body_buf.appendSlice(alloc, "&EndTime=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.filters) |list| {
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
    if (input.instance_types) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceType.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.product_descriptions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProductDescription.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.start_time) |v| {
        try body_buf.appendSlice(alloc, "&StartTime=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeSpotPriceHistoryOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeSpotPriceHistoryOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "spotPriceHistorySet")) {
                    result.spot_price_history = try serde.deserializeSpotPriceHistoryList(&reader, alloc, "item");
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
