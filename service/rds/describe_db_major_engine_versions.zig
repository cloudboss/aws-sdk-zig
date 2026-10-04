const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBMajorEngineVersion = @import("db_major_engine_version.zig").DBMajorEngineVersion;
const serde = @import("serde.zig");

pub const DescribeDBMajorEngineVersionsInput = struct {
    /// The database engine to return major version details for.
    ///
    /// Valid Values:
    ///
    /// * `aurora-mysql`
    /// * `aurora-postgresql`
    /// * `custom-sqlserver-ee`
    /// * `custom-sqlserver-se`
    /// * `custom-sqlserver-web`
    /// * `db2-ae`
    /// * `db2-se`
    /// * `mariadb`
    /// * `mysql`
    /// * `oracle-ee`
    /// * `oracle-ee-cdb`
    /// * `oracle-se2`
    /// * `oracle-se2-cdb`
    /// * `postgres`
    /// * `sqlserver-ee`
    /// * `sqlserver-se`
    /// * `sqlserver-ex`
    /// * `sqlserver-web`
    engine: ?[]const u8 = null,

    /// A specific database major engine version to return details for.
    ///
    /// Example: `8.4`
    major_engine_version: ?[]const u8 = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more than the
    /// `MaxRecords` value is available, a pagination token called a marker is
    /// included in the response so you can retrieve the remaining results.
    ///
    /// Default: 100
    max_records: ?i32 = null,
};

pub const DescribeDBMajorEngineVersionsOutput = struct {
    /// A list of `DBMajorEngineVersion` elements.
    db_major_engine_versions: ?[]const DBMajorEngineVersion = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDBMajorEngineVersionsInput, options: CallOptions) !DescribeDBMajorEngineVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDBMajorEngineVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeDBMajorEngineVersions&Version=2014-10-31");
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.major_engine_version) |v| {
        try body_buf.appendSlice(allocator, "&MajorEngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDBMajorEngineVersionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeDBMajorEngineVersionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeDBMajorEngineVersionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBMajorEngineVersions")) {
                    result.db_major_engine_versions = try serde.deserializeDBMajorEngineVersionsList(allocator, &reader, "DBMajorEngineVersion");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
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
