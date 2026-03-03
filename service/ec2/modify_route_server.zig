const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RouteServerPersistRoutesAction = @import("route_server_persist_routes_action.zig").RouteServerPersistRoutesAction;
const RouteServer = @import("route_server.zig").RouteServer;
const serde = @import("serde.zig");

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
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyRouteServerInput, options: CallOptions) !ModifyRouteServerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyRouteServerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyRouteServer&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.persist_routes) |v| {
        try body_buf.appendSlice(allocator, "&PersistRoutes=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.persist_routes_duration) |v| {
        try body_buf.appendSlice(allocator, "&PersistRoutesDuration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&RouteServerId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.route_server_id);
    if (input.sns_notifications_enabled) |v| {
        try body_buf.appendSlice(allocator, "&SnsNotificationsEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyRouteServerOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyRouteServerOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "routeServer")) {
                    result.route_server = try serde.deserializeRouteServer(allocator, &reader);
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
