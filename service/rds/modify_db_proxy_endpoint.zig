const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBProxyEndpoint = @import("db_proxy_endpoint.zig").DBProxyEndpoint;
const serde = @import("serde.zig");

pub const ModifyDBProxyEndpointInput = struct {
    /// The name of the DB proxy sociated with the DB proxy endpoint that you want
    /// to modify.
    db_proxy_endpoint_name: []const u8,

    /// The new identifier for the `DBProxyEndpoint`. An identifier must begin with
    /// a letter and must contain only ASCII letters, digits, and hyphens; it can't
    /// end with a hyphen or contain two consecutive hyphens.
    new_db_proxy_endpoint_name: ?[]const u8 = null,

    /// The VPC security group IDs for the DB proxy endpoint. When the DB proxy
    /// endpoint uses a different VPC than the original proxy, you also specify a
    /// different set of security group IDs than for the original proxy.
    vpc_security_group_ids: ?[]const []const u8 = null,
};

pub const ModifyDBProxyEndpointOutput = struct {
    /// The `DBProxyEndpoint` object representing the new settings for the DB proxy
    /// endpoint.
    db_proxy_endpoint: ?DBProxyEndpoint = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBProxyEndpointInput, options: CallOptions) !ModifyDBProxyEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBProxyEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBProxyEndpoint&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBProxyEndpointName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_proxy_endpoint_name);
    if (input.new_db_proxy_endpoint_name) |v| {
        try body_buf.appendSlice(allocator, "&NewDBProxyEndpointName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.vpc_security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VpcSecurityGroupIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBProxyEndpointOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBProxyEndpointResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBProxyEndpointOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBProxyEndpoint")) {
                    result.db_proxy_endpoint = try serde.deserializeDBProxyEndpoint(allocator, &reader);
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
