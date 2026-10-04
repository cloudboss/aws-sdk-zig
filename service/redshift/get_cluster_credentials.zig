const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const GetClusterCredentialsInput = struct {
    /// Create a database user with the name specified for the user named in
    /// `DbUser` if one does not exist.
    auto_create: ?bool = null,

    /// The unique identifier of the cluster that contains the database for which
    /// you are
    /// requesting credentials. This parameter is case sensitive.
    cluster_identifier: ?[]const u8 = null,

    /// The custom domain name for the cluster credentials.
    custom_domain_name: ?[]const u8 = null,

    /// A list of the names of existing database groups that the user named in
    /// `DbUser` will join for the current session, in addition to any group
    /// memberships for an existing user. If not specified, a new user is added only
    /// to
    /// PUBLIC.
    ///
    /// Database group name constraints
    ///
    /// * Must be 1 to 64 alphanumeric characters or hyphens
    ///
    /// * Must contain only lowercase letters, numbers, underscore, plus sign,
    ///   period
    /// (dot), at symbol (@), or hyphen.
    ///
    /// * First character must be a letter.
    ///
    /// * Must not contain a colon ( : ) or slash ( / ).
    ///
    /// * Cannot be a reserved word. A list of reserved words can be found in
    ///   [Reserved
    ///   Words](http://docs.aws.amazon.com/redshift/latest/dg/r_pg_keywords.html)
    ///   in the Amazon
    /// Redshift Database Developer Guide.
    db_groups: ?[]const []const u8 = null,

    /// The name of a database that `DbUser` is authorized to log on to. If
    /// `DbName` is not specified, `DbUser` can log on to any existing
    /// database.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 64 alphanumeric characters or hyphens
    ///
    /// * Must contain uppercase or lowercase letters, numbers, underscore, plus
    ///   sign, period
    /// (dot), at symbol (@), or hyphen.
    ///
    /// * First character must be a letter.
    ///
    /// * Must not contain a colon ( : ) or slash ( / ).
    ///
    /// * Cannot be a reserved word. A list of reserved words can be found in
    ///   [Reserved
    ///   Words](http://docs.aws.amazon.com/redshift/latest/dg/r_pg_keywords.html)
    ///   in the Amazon
    /// Redshift Database Developer Guide.
    db_name: ?[]const u8 = null,

    /// The name of a database user. If a user name matching `DbUser` exists in
    /// the database, the temporary user credentials have the same permissions as
    /// the existing
    /// user. If `DbUser` doesn't exist in the database and `Autocreate`
    /// is `True`, a new user is created using the value for `DbUser` with
    /// PUBLIC permissions. If a database user matching the value for `DbUser`
    /// doesn't exist and `Autocreate` is `False`, then the command
    /// succeeds but the connection attempt will fail because the user doesn't exist
    /// in the
    /// database.
    ///
    /// For more information, see [CREATE
    /// USER](https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_USER.html) in
    /// the Amazon
    /// Redshift Database Developer Guide.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 64 alphanumeric characters or hyphens. The user name can't be
    /// `PUBLIC`.
    ///
    /// * Must contain uppercase or lowercase letters, numbers, underscore, plus
    ///   sign, period
    /// (dot), at symbol (@), or hyphen.
    ///
    /// * First character must be a letter.
    ///
    /// * Must not contain a colon ( : ) or slash ( / ).
    ///
    /// * Cannot be a reserved word. A list of reserved words can be found in
    ///   [Reserved
    ///   Words](http://docs.aws.amazon.com/redshift/latest/dg/r_pg_keywords.html)
    ///   in the Amazon
    /// Redshift Database Developer Guide.
    db_user: []const u8,

    /// The number of seconds until the returned temporary password expires.
    ///
    /// Constraint: minimum 900, maximum 3600.
    ///
    /// Default: 900
    duration_seconds: ?i32 = null,
};

pub const GetClusterCredentialsOutput = struct {
    /// A temporary password that authorizes the user name returned by `DbUser`
    /// to log on to the database `DbName`.
    db_password: ?[]const u8 = null,

    /// A database user name that is authorized to log on to the database `DbName`
    /// using the password `DbPassword`. If the specified DbUser exists in the
    /// database, the new user name has the same database permissions as the the
    /// user named in
    /// DbUser. By default, the user is added to PUBLIC. If the `DbGroups` parameter
    /// is specifed, `DbUser` is added to the listed groups for any sessions created
    /// using these credentials.
    db_user: ?[]const u8 = null,

    /// The date and time the password in `DbPassword` expires.
    expiration: ?i64 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetClusterCredentialsInput, options: CallOptions) !GetClusterCredentialsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetClusterCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetClusterCredentials&Version=2012-12-01");
    if (input.auto_create) |v| {
        try body_buf.appendSlice(allocator, "&AutoCreate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.custom_domain_name) |v| {
        try body_buf.appendSlice(allocator, "&CustomDomainName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DbGroups.DbGroup.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.db_name) |v| {
        try body_buf.appendSlice(allocator, "&DbName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DbUser=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_user);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetClusterCredentialsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetClusterCredentialsResult")) break;
            },
            else => {},
        }
    }

    var result: GetClusterCredentialsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DbPassword")) {
                    result.db_password = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DbUser")) {
                    result.db_user = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = aws.date.parseIso8601(try reader.readElementText()) catch null;
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
