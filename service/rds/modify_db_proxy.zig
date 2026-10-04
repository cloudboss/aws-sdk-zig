const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserAuthConfig = @import("user_auth_config.zig").UserAuthConfig;
const DefaultAuthScheme = @import("default_auth_scheme.zig").DefaultAuthScheme;
const DBProxy = @import("db_proxy.zig").DBProxy;
const serde = @import("serde.zig");

pub const ModifyDBProxyInput = struct {
    /// The new authentication settings for the `DBProxy`.
    auth: ?[]const UserAuthConfig = null,

    /// The identifier for the `DBProxy` to modify.
    db_proxy_name: []const u8,

    /// Specifies whether the proxy logs detailed connection and query information.
    /// When you enable `DebugLogging`, the proxy captures connection details and
    /// connection pool behavior from your queries. Debug logging increases
    /// CloudWatch costs and can impact proxy performance. Enable this option only
    /// when you need to troubleshoot connection or performance issues.
    debug_logging: ?bool = null,

    /// The default authentication scheme that the proxy uses for client connections
    /// to the proxy and connections from the proxy to the underlying database.
    /// Valid values are `NONE` and `IAM_AUTH`. When set to `IAM_AUTH`, the proxy
    /// uses end-to-end IAM authentication to connect to the database.
    default_auth_scheme: ?DefaultAuthScheme = null,

    /// The number of seconds that a connection to the proxy can be inactive before
    /// the proxy disconnects it. You can set this value higher or lower than the
    /// connection timeout limit for the associated database.
    idle_client_timeout: ?i32 = null,

    /// The new identifier for the `DBProxy`. An identifier must begin with a letter
    /// and must contain only ASCII letters, digits, and hyphens; it can't end with
    /// a hyphen or contain two consecutive hyphens.
    new_db_proxy_name: ?[]const u8 = null,

    /// Whether Transport Layer Security (TLS) encryption is required for
    /// connections to the proxy. By enabling this setting, you can enforce
    /// encrypted TLS connections to the proxy, even if the associated database
    /// doesn't use TLS.
    require_tls: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM role that the proxy uses to access
    /// secrets in Amazon Web Services Secrets Manager.
    role_arn: ?[]const u8 = null,

    /// The new list of security groups for the `DBProxy`.
    security_groups: ?[]const []const u8 = null,
};

pub const ModifyDBProxyOutput = struct {
    /// The `DBProxy` object representing the new settings for the proxy.
    db_proxy: ?DBProxy = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBProxyInput, options: CallOptions) !ModifyDBProxyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBProxyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBProxy&Version=2014-10-31");
    if (input.auth) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.auth_scheme) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Auth.member.{d}.AuthScheme=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.client_password_auth_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Auth.member.{d}.ClientPasswordAuthType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.description) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Auth.member.{d}.Description=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.iam_auth) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Auth.member.{d}.IAMAuth=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.secret_arn) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Auth.member.{d}.SecretArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.user_name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Auth.member.{d}.UserName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&DBProxyName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_proxy_name);
    if (input.debug_logging) |v| {
        try body_buf.appendSlice(allocator, "&DebugLogging=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.default_auth_scheme) |v| {
        try body_buf.appendSlice(allocator, "&DefaultAuthScheme=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.idle_client_timeout) |v| {
        try body_buf.appendSlice(allocator, "&IdleClientTimeout=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.new_db_proxy_name) |v| {
        try body_buf.appendSlice(allocator, "&NewDBProxyName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.require_tls) |v| {
        try body_buf.appendSlice(allocator, "&RequireTLS=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.role_arn) |v| {
        try body_buf.appendSlice(allocator, "&RoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.security_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroups.member.{d}=", .{n}) catch continue;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBProxyOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBProxyResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBProxyOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBProxy")) {
                    result.db_proxy = try serde.deserializeDBProxy(allocator, &reader);
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
