const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetClusterCredentialsWithIAMInput = struct {
    /// The unique identifier of the cluster that contains the database for which
    /// you are
    /// requesting credentials.
    cluster_identifier: ?[]const u8 = null,

    /// The custom domain name for the IAM message cluster credentials.
    custom_domain_name: ?[]const u8 = null,

    /// The name of the database for which you are requesting credentials.
    /// If the database name is specified, the IAM policy must allow access to the
    /// resource `dbname` for the specified database name.
    /// If the database name is not specified, access to all databases is allowed.
    db_name: ?[]const u8 = null,

    /// The number of seconds until the returned temporary password expires.
    ///
    /// Range: 900-3600. Default: 900.
    duration_seconds: ?i32 = null,
};

pub const GetClusterCredentialsWithIAMOutput = struct {
    /// A temporary password that you provide when you connect to a database.
    db_password: ?[]const u8 = null,

    /// A database user name that you provide when you connect to a database. The
    /// database user is mapped 1:1 to the source IAM identity.
    db_user: ?[]const u8 = null,

    /// The time (UTC) when the temporary password expires. After this timestamp, a
    /// log in with the temporary password fails.
    expiration: ?i64 = null,

    /// Reserved for future use.
    next_refresh_time: ?i64 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetClusterCredentialsWithIAMInput, options: CallOptions) !GetClusterCredentialsWithIAMOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetClusterCredentialsWithIAMInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetClusterCredentialsWithIAM&Version=2012-12-01");
    if (input.cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.custom_domain_name) |v| {
        try body_buf.appendSlice(allocator, "&CustomDomainName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_name) |v| {
        try body_buf.appendSlice(allocator, "&DbName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.duration_seconds) |v| {
        try body_buf.appendSlice(allocator, "&DurationSeconds=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetClusterCredentialsWithIAMOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetClusterCredentialsWithIAMResult")) break;
            },
            else => {},
        }
    }

    var result: GetClusterCredentialsWithIAMOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DbPassword")) {
                    result.db_password = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbUser")) {
                    result.db_user = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NextRefreshTime")) {
                    result.next_refresh_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
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
