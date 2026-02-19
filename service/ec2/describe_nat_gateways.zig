const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const NatGateway = @import("nat_gateway.zig").NatGateway;
const serde = @import("serde.zig");

pub const DescribeNatGatewaysInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The filters.
    ///
    /// * `nat-gateway-id` - The ID of the NAT gateway.
    ///
    /// * `state` - The state of the NAT gateway (`pending` |
    /// `failed` | `available` | `deleting` | `deleted`).
    ///
    /// * `subnet-id` - The ID of the subnet in which the NAT gateway resides.
    ///
    /// * `tag` - The key/value combination of a tag assigned to the resource. Use
    ///   the tag key in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    ///
    /// * `tag-key` - The key of a tag assigned to the resource. Use this filter to
    ///   find all resources assigned a tag with a specific key, regardless of the
    ///   tag value.
    ///
    /// * `vpc-id` - The ID of the VPC in which the NAT gateway resides.
    filter: ?[]const Filter = null,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The IDs of the NAT gateways.
    nat_gateway_ids: ?[]const []const u8 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,
};

pub const DescribeNatGatewaysOutput = struct {
    /// Information about the NAT gateways.
    nat_gateways: ?[]const NatGateway = null,

    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there are no more items to return.
    next_token: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeNatGatewaysOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeNatGatewaysInput, options: Options) !DescribeNatGatewaysOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeNatGatewaysInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeNatGateways&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
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
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.nat_gateway_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NatGatewayId.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeNatGatewaysOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeNatGatewaysOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "natGatewaySet")) {
                    result.nat_gateways = try serde.deserializeNatGatewayList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
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
