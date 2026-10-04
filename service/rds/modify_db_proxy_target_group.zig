const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionPoolConfiguration = @import("connection_pool_configuration.zig").ConnectionPoolConfiguration;
const DBProxyTargetGroup = @import("db_proxy_target_group.zig").DBProxyTargetGroup;
const serde = @import("serde.zig");

pub const ModifyDBProxyTargetGroupInput = struct {
    /// The settings that determine the size and behavior of the connection pool for
    /// the target group.
    connection_pool_config: ?ConnectionPoolConfiguration = null,

    /// The name of the proxy.
    db_proxy_name: []const u8,

    /// The new name for the modified `DBProxyTarget`. An identifier must begin with
    /// a letter and must contain only ASCII letters, digits, and hyphens; it can't
    /// end with a hyphen or contain two consecutive hyphens.
    ///
    /// You can't rename the `default` target group.
    new_name: ?[]const u8 = null,

    /// The name of the target group to modify.
    target_group_name: []const u8,
};

pub const ModifyDBProxyTargetGroupOutput = struct {
    /// The settings of the modified `DBProxyTarget`.
    db_proxy_target_group: ?DBProxyTargetGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBProxyTargetGroupInput, options: CallOptions) !ModifyDBProxyTargetGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBProxyTargetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBProxyTargetGroup&Version=2014-10-31");
    if (input.connection_pool_config) |v| {
        if (v.connection_borrow_timeout) |sv| {
            try body_buf.appendSlice(allocator, "&ConnectionPoolConfig.ConnectionBorrowTimeout=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.init_query) |sv| {
            try body_buf.appendSlice(allocator, "&ConnectionPoolConfig.InitQuery=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.max_connections_percent) |sv| {
            try body_buf.appendSlice(allocator, "&ConnectionPoolConfig.MaxConnectionsPercent=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.max_idle_connections_percent) |sv| {
            try body_buf.appendSlice(allocator, "&ConnectionPoolConfig.MaxIdleConnectionsPercent=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.session_pinning_filters) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ConnectionPoolConfig.SessionPinningFilters.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
    }
    try body_buf.appendSlice(allocator, "&DBProxyName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_proxy_name);
    if (input.new_name) |v| {
        try body_buf.appendSlice(allocator, "&NewName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&TargetGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_group_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBProxyTargetGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBProxyTargetGroupResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBProxyTargetGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBProxyTargetGroup")) {
                    result.db_proxy_target_group = try serde.deserializeDBProxyTargetGroup(allocator, &reader);
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
