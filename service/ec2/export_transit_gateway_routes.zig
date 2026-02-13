const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const serde = @import("serde.zig");

/// Exports routes from the specified transit gateway route table to the
/// specified S3 bucket.
/// By default, all routes are exported. Alternatively, you can filter by CIDR
/// range.
///
/// The routes are saved to the specified bucket in a JSON file. For more
/// information, see
/// [Export route tables
/// to Amazon
/// S3](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-route-tables.html#tgw-export-route-tables) in the *Amazon Web Services Transit Gateways Guide*.
pub const ExportTransitGatewayRoutesInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// One or more filters. The possible values are:
    ///
    /// * `attachment.transit-gateway-attachment-id` - The id of the transit gateway
    ///   attachment.
    ///
    /// * `attachment.resource-id` - The resource id of the transit gateway
    ///   attachment.
    ///
    /// * `route-search.exact-match` - The exact match of the specified filter.
    ///
    /// * `route-search.longest-prefix-match` - The longest prefix that matches the
    ///   route.
    ///
    /// * `route-search.subnet-of-match` - The routes with a subnet that match the
    ///   specified CIDR filter.
    ///
    /// * `route-search.supernet-of-match` - The routes with a CIDR that encompass
    ///   the CIDR filter. For example, if you have 10.0.1.0/29 and 10.0.1.0/31
    ///   routes in your route table and you specify supernet-of-match as
    ///   10.0.1.0/30, then the result returns 10.0.1.0/29.
    ///
    /// * `state` - The state of the route (`active` | `blackhole`).
    ///
    /// * `transit-gateway-route-destination-cidr-block` - The CIDR range.
    ///
    /// * `type` - The type of route (`propagated` |
    /// `static`).
    filters: ?[]const Filter = null,

    /// The name of the S3 bucket.
    s_3_bucket: []const u8,

    /// The ID of the route table.
    transit_gateway_route_table_id: []const u8,
};

pub const ExportTransitGatewayRoutesOutput = struct {
    /// The URL of the exported file in Amazon S3. For example,
    /// s3://*bucket_name*/VPCTransitGateway/TransitGatewayRouteTables/*file_name*.
    s_3_location: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ExportTransitGatewayRoutesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ExportTransitGatewayRoutesInput, options: Options) !ExportTransitGatewayRoutesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ExportTransitGatewayRoutesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ExportTransitGatewayRoutes&Version=2016-11-15");
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
    try body_buf.appendSlice(alloc, "&S3Bucket=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.s_3_bucket);
    try body_buf.appendSlice(alloc, "&TransitGatewayRouteTableId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.transit_gateway_route_table_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ExportTransitGatewayRoutesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ExportTransitGatewayRoutesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "s3Location")) {
                    result.s_3_location = try alloc.dupe(u8, try reader.readElementText());
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
