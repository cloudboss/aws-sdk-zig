const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserAuthConfig = @import("user_auth_config.zig").UserAuthConfig;
const DefaultAuthScheme = @import("default_auth_scheme.zig").DefaultAuthScheme;
const EndpointNetworkType = @import("endpoint_network_type.zig").EndpointNetworkType;
const EngineFamily = @import("engine_family.zig").EngineFamily;
const Tag = @import("tag.zig").Tag;
const TargetConnectionNetworkType = @import("target_connection_network_type.zig").TargetConnectionNetworkType;
const DBProxy = @import("db_proxy.zig").DBProxy;
const serde = @import("serde.zig");

pub const CreateDBProxyInput = struct {
    /// The authorization mechanism that the proxy uses.
    auth: ?[]const UserAuthConfig = null,

    /// The identifier for the proxy. This name must be unique for all proxies owned
    /// by your Amazon Web Services account in the specified Amazon Web Services
    /// Region. An identifier must begin with a letter and must contain only ASCII
    /// letters, digits, and hyphens; it can't end with a hyphen or contain two
    /// consecutive hyphens.
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
    /// uses end-to-end IAM authentication to connect to the database. If you don't
    /// specify `DefaultAuthScheme` or specify this parameter as `NONE`, you must
    /// specify the `Auth` option.
    default_auth_scheme: ?DefaultAuthScheme = null,

    /// The network type of the DB proxy endpoint. The network type determines the
    /// IP version that the proxy endpoint supports.
    ///
    /// Valid values:
    ///
    /// * `IPV4` - The proxy endpoint supports IPv4 only.
    /// * `IPV6` - The proxy endpoint supports IPv6 only.
    /// * `DUAL` - The proxy endpoint supports both IPv4 and IPv6.
    ///
    /// Default: `IPV4`
    ///
    /// Constraints:
    ///
    /// * If you specify `IPV6` or `DUAL`, the VPC and all subnets must have an IPv6
    ///   CIDR block.
    /// * If you specify `IPV6` or `DUAL`, the VPC tenancy cannot be `dedicated`.
    endpoint_network_type: ?EndpointNetworkType = null,

    /// The kinds of databases that the proxy can connect to. This value determines
    /// which database network protocol the proxy recognizes when it interprets
    /// network traffic to and from the database. For Aurora MySQL, RDS for MariaDB,
    /// and RDS for MySQL databases, specify `MYSQL`. For Aurora PostgreSQL and RDS
    /// for PostgreSQL databases, specify `POSTGRESQL`. For RDS for Microsoft SQL
    /// Server, specify `SQLSERVER`.
    engine_family: EngineFamily,

    /// The number of seconds that a connection to the proxy can be inactive before
    /// the proxy disconnects it. You can set this value higher or lower than the
    /// connection timeout limit for the associated database.
    idle_client_timeout: ?i32 = null,

    /// Specifies whether Transport Layer Security (TLS) encryption is required for
    /// connections to the proxy. By enabling this setting, you can enforce
    /// encrypted TLS connections to the proxy.
    require_tls: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM role that the proxy uses to access
    /// secrets in Amazon Web Services Secrets Manager.
    role_arn: []const u8,

    /// An optional set of key-value pairs to associate arbitrary data of your
    /// choosing with the proxy.
    tags: ?[]const Tag = null,

    /// The network type that the proxy uses to connect to the target database. The
    /// network type determines the IP version that the proxy uses for connections
    /// to the database.
    ///
    /// Valid values:
    ///
    /// * `IPV4` - The proxy connects to the database using IPv4 only.
    /// * `IPV6` - The proxy connects to the database using IPv6 only.
    ///
    /// Default: `IPV4`
    ///
    /// Constraints:
    ///
    /// * If you specify `IPV6`, the database must support dual-stack mode. RDS
    ///   doesn't support IPv6-only databases.
    /// * All targets registered with the proxy must be compatible with the
    ///   specified network type.
    target_connection_network_type: ?TargetConnectionNetworkType = null,

    /// One or more VPC security group IDs to associate with the new proxy.
    vpc_security_group_ids: ?[]const []const u8 = null,

    /// One or more VPC subnet IDs to associate with the new proxy.
    vpc_subnet_ids: []const []const u8,
};

pub const CreateDBProxyOutput = struct {
    /// The `DBProxy` structure corresponding to the new proxy.
    db_proxy: ?DBProxy = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDBProxyInput, options: CallOptions) !CreateDBProxyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDBProxyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateDBProxy&Version=2014-10-31");
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
    if (input.endpoint_network_type) |v| {
        try body_buf.appendSlice(allocator, "&EndpointNetworkType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&EngineFamily=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine_family.wireName());
    if (input.idle_client_timeout) |v| {
        try body_buf.appendSlice(allocator, "&IdleClientTimeout=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.require_tls) |v| {
        try body_buf.appendSlice(allocator, "&RequireTLS=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&RoleArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.role_arn);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.target_connection_network_type) |v| {
        try body_buf.appendSlice(allocator, "&TargetConnectionNetworkType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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
    for (input.vpc_subnet_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VpcSubnetIds.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDBProxyOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDBProxyResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDBProxyOutput = .{};
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
