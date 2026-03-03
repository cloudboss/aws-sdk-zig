const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ReservedInstanceLimitPrice = @import("reserved_instance_limit_price.zig").ReservedInstanceLimitPrice;
const serde = @import("serde.zig");

pub const PurchaseReservedInstancesOfferingInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making
    /// the request, and provides an error response. If you have the required
    /// permissions, the error
    /// response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The number of Reserved Instances to purchase.
    instance_count: i32,

    /// Specified for Reserved Instance Marketplace offerings to limit the total
    /// order and ensure
    /// that the Reserved Instances are not purchased at unexpected prices.
    limit_price: ?ReservedInstanceLimitPrice = null,

    /// The time at which to purchase the Reserved Instance, in UTC format (for
    /// example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    purchase_time: ?i64 = null,

    /// The ID of the Reserved Instance offering to purchase.
    reserved_instances_offering_id: []const u8,
};

pub const PurchaseReservedInstancesOfferingOutput = struct {
    /// The IDs of the purchased Reserved Instances. If your purchase crosses into a
    /// discounted
    /// pricing tier, the final Reserved Instances IDs might change. For more
    /// information, see [Crossing pricing
    /// tiers](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts-reserved-instances-application.html#crossing-pricing-tiers) in the *Amazon EC2 User Guide*.
    reserved_instances_id: ?[]const u8 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PurchaseReservedInstancesOfferingInput, options: Options) !PurchaseReservedInstancesOfferingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PurchaseReservedInstancesOfferingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=PurchaseReservedInstancesOffering&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&InstanceCount=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.instance_count}) catch "");
    if (input.limit_price) |v| {
        if (v.amount) |sv| {
            try body_buf.appendSlice(allocator, "&LimitPrice.Amount=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.currency_code) |sv| {
            try body_buf.appendSlice(allocator, "&LimitPrice.CurrencyCode=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
    }
    if (input.purchase_time) |v| {
        try body_buf.appendSlice(allocator, "&PurchaseTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&ReservedInstancesOfferingId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.reserved_instances_offering_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PurchaseReservedInstancesOfferingOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: PurchaseReservedInstancesOfferingOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "reservedInstancesId")) {
                    result.reserved_instances_id = try allocator.dupe(u8, try reader.readElementText());
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
