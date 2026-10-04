const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DBEngineVersion = @import("db_engine_version.zig").DBEngineVersion;
const serde = @import("serde.zig");

pub const DescribeDBEngineVersionsInput = struct {
    /// The name of a specific parameter group family to return details for.
    ///
    /// Constraints:
    ///
    /// * If provided, must match an existing
    /// `DBParameterGroupFamily`.
    db_parameter_group_family: ?[]const u8 = null,

    /// Indicates that only the default version of the specified engine or engine
    /// and major
    /// version combination is returned.
    default_only: ?bool = null,

    /// The database engine to return.
    engine: ?[]const u8 = null,

    /// The database engine version to return.
    ///
    /// Example: `3.6.0`
    engine_version: ?[]const u8 = null,

    /// This parameter is not currently supported.
    filters: ?[]const Filter = null,

    /// If this parameter is specified and the requested engine supports the
    /// `CharacterSetName` parameter for `CreateDBInstance`, the response includes a
    /// list of supported character sets for each engine version.
    list_supported_character_sets: ?bool = null,

    /// If this parameter is specified and the requested engine supports the
    /// `TimeZone` parameter for `CreateDBInstance`, the response includes a list of
    /// supported time zones for each engine version.
    list_supported_timezones: ?bool = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response
    /// includes only records beyond the marker, up to the value specified by
    /// `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than
    /// the specified `MaxRecords` value, a pagination token (marker) is included
    /// in the response so that the remaining results can be retrieved.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,
};

pub const DescribeDBEngineVersionsOutput = struct {
    /// Detailed information about one or more engine versions.
    db_engine_versions: ?[]const DBEngineVersion = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response
    /// includes only records beyond the marker, up to the value specified by
    /// `MaxRecords`.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDBEngineVersionsInput, options: CallOptions) !DescribeDBEngineVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDBEngineVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "DocDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeDBEngineVersions&Version=2014-10-31");
    if (input.db_parameter_group_family) |v| {
        try body_buf.appendSlice(allocator, "&DBParameterGroupFamily=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.default_only) |v| {
        try body_buf.appendSlice(allocator, "&DefaultOnly=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
            }
            for (item.values, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.Value.{d}=", .{n, n_1}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                }
            }
        }
    }
    if (input.list_supported_character_sets) |v| {
        try body_buf.appendSlice(allocator, "&ListSupportedCharacterSets=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.list_supported_timezones) |v| {
        try body_buf.appendSlice(allocator, "&ListSupportedTimezones=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDBEngineVersionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeDBEngineVersionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeDBEngineVersionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBEngineVersions")) {
                    result.db_engine_versions = try serde.deserializeDBEngineVersionList(allocator, &reader, "DBEngineVersion");
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
