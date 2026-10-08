const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DBEngineVersion = @import("db_engine_version.zig").DBEngineVersion;
const serde = @import("serde.zig");

pub const DescribeDBEngineVersionsInput = struct {
    /// The name of a specific DB parameter group family to return details for.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match an existing DB parameter group family.
    db_parameter_group_family: ?[]const u8 = null,

    /// Specifies whether to return only the default version of the specified engine
    /// or the engine and major version combination.
    default_only: ?bool = null,

    /// The database engine to return version details for.
    ///
    /// Valid Values:
    ///
    /// * `aurora-mysql`
    /// * `aurora-postgresql`
    /// * `custom-oracle-ee`
    /// * `custom-oracle-ee-cdb`
    /// * `custom-oracle-se2`
    /// * `custom-oracle-se2-cdb`
    /// * `db2-ae`
    /// * `db2-ce`
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
    /// * `sqlserver-dev-ee`
    engine: ?[]const u8 = null,

    /// A specific database engine version to return details for.
    ///
    /// Example: `5.1.49`
    engine_version: ?[]const u8 = null,

    /// A filter that specifies one or more DB engine versions to describe.
    ///
    /// Supported filters:
    ///
    /// * `db-parameter-group-family` - Accepts parameter groups family names. The
    ///   results list only includes information about the DB engine versions for
    ///   these parameter group families.
    /// * `engine` - Accepts engine names. The results list only includes
    ///   information about the DB engine versions for these engines.
    /// * `engine-mode` - Accepts DB engine modes. The results list only includes
    ///   information about the DB engine versions for these engine modes. Valid DB
    ///   engine modes are the following:
    ///
    /// * `global`
    /// * `multimaster`
    /// * `parallelquery`
    /// * `provisioned`
    /// * `serverless`
    ///
    /// * `engine-version` - Accepts engine versions. The results list only includes
    ///   information about the DB engine versions for these engine versions.
    /// * `status` - Accepts engine version statuses. The results list only includes
    ///   information about the DB engine versions for these statuses. Valid
    ///   statuses are the following:
    ///
    /// * `available`
    /// * `deprecated`
    filters: ?[]const Filter = null,

    /// Specifies whether to also list the engine versions that aren't available.
    /// The default is to list only available engine versions.
    include_all: ?bool = null,

    /// Specifies whether to list the supported character sets for each engine
    /// version.
    ///
    /// If this parameter is enabled and the requested engine supports the
    /// `CharacterSetName` parameter for `CreateDBInstance`, the response includes a
    /// list of supported character sets for each engine version.
    ///
    /// For RDS Custom, the default is not to list supported character sets. If you
    /// enable this parameter, RDS Custom returns no results.
    list_supported_character_sets: ?bool = null,

    /// Specifies whether to list the supported time zones for each engine version.
    ///
    /// If this parameter is enabled and the requested engine supports the
    /// `TimeZone` parameter for `CreateDBInstance`, the response includes a list of
    /// supported time zones for each engine version.
    ///
    /// For RDS Custom, the default is not to list supported time zones. If you
    /// enable this parameter, RDS Custom returns no results.
    list_supported_timezones: ?bool = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more than the
    /// `MaxRecords` value is available, a pagination token called a marker is
    /// included in the response so you can retrieve the remaining results.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,
};

pub const DescribeDBEngineVersionsOutput = struct {
    /// A list of `DBEngineVersion` elements.
    db_engine_versions: ?[]const DBEngineVersion = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
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
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.Value.{d}=", .{ n, n_1 }) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                }
            }
        }
    }
    if (input.include_all) |v| {
        try body_buf.appendSlice(allocator, "&IncludeAll=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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
