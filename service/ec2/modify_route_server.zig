const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RouteServerPersistRoutesAction = @import("route_server_persist_routes_action.zig").RouteServerPersistRoutesAction;
const RouteServer = @import("route_server.zig").RouteServer;

/// Modifies the configuration of an existing route server.
///
/// Amazon VPC Route Server simplifies routing for traffic between workloads
/// that are deployed within a VPC and its internet gateways. With this feature,
/// VPC Route Server dynamically updates VPC and internet gateway route tables
/// with your preferred IPv4 or IPv6 routes to achieve routing fault tolerance
/// for those workloads. This enables you to automatically reroute traffic
/// within a VPC, which increases the manageability of VPC routing and
/// interoperability with third-party workloads.
///
/// Route server supports the follow route table types:
///
/// * VPC route tables not associated with subnets
///
/// * Subnet route tables
///
/// * Internet gateway route tables
///
/// Route server does not support route tables associated with virtual private
/// gateways. To propagate routes into a transit gateway route table, use
/// [Transit Gateway
/// Connect](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-connect.html).
///
/// For more information see [Dynamic routing in your VPC with VPC Route
/// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
pub const ModifyRouteServerInput = struct {
    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Specifies whether to persist routes after all BGP sessions are terminated.
    ///
    /// * enable: Routes will be persisted in FIB and RIB after all BGP sessions are
    ///   terminated.
    ///
    /// * disable: Routes will not be persisted in FIB and RIB after all BGP
    ///   sessions are terminated.
    ///
    /// * reset: If a route server has persisted routes due to all BGP sessions
    ///   having ended, reset will withdraw all routes and reset route server to an
    ///   empty FIB and RIB.
    persist_routes: ?RouteServerPersistRoutesAction = null,

    /// The number of minutes a route server will wait after BGP is re-established
    /// to unpersist the routes in the FIB and RIB. Value must be in the range of
    /// 1-5. Required if PersistRoutes is `enabled`.
    ///
    /// If you set the duration to 1 minute, then when your network appliance
    /// re-establishes BGP with route server, it has 1 minute to relearn it's
    /// adjacent network and advertise those routes to route server before route
    /// server resumes normal functionality. In most cases, 1 minute is probably
    /// sufficient. If, however, you have concerns that your BGP network may not be
    /// capable of fully re-establishing and re-learning everything in 1 minute, you
    /// can increase the duration up to 5 minutes.
    persist_routes_duration: ?i64 = null,

    /// The ID of the route server to modify.
    route_server_id: []const u8,

    /// Specifies whether to enable SNS notifications for route server events.
    /// Enabling SNS notifications persists BGP status changes to an SNS topic
    /// provisioned by Amazon Web Services.
    sns_notifications_enabled: ?bool = null,
};

pub const ModifyRouteServerOutput = struct {
    /// Information about the modified route server.
    route_server: ?RouteServer = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ModifyRouteServerOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyRouteServerInput, options: Options) !ModifyRouteServerOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyRouteServerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyRouteServer&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.persist_routes) |v| {
        try body_buf.appendSlice(alloc, "&PersistRoutes=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.persist_routes_duration) |v| {
        try body_buf.appendSlice(alloc, "&PersistRoutesDuration=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(alloc, "&RouteServerId=");
    try appendUrlEncoded(alloc, &body_buf, input.route_server_id);
    if (input.sns_notifications_enabled) |v| {
        try body_buf.appendSlice(alloc, "&SnsNotificationsEnabled=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ModifyRouteServerOutput {
    _ = status;
    _ = body;
    const result: ModifyRouteServerOutput = .{ .allocator = alloc };

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
