const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DataMigration = @import("data_migration.zig").DataMigration;

pub const DescribeDataMigrationsInput = struct {
    /// Filters applied to the data migrations.
    filters: ?[]const Filter = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is
    /// specified, the response includes only records beyond the marker, up to the
    /// value specified
    /// by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the
    /// specified `MaxRecords` value, a pagination token called a marker is included
    /// in
    /// the response so that the remaining results can be retrieved.
    max_records: ?i32 = null,

    /// An option to set to avoid returning information about settings. Use this to
    /// reduce
    /// overhead when setting information is too large. To use this option, choose
    /// `true`; otherwise, choose `false` (the default).
    without_settings: ?bool = null,

    /// An option to set to avoid returning information about statistics. Use this
    /// to reduce
    /// overhead when statistics information is too large. To use this option,
    /// choose
    /// `true`; otherwise, choose `false` (the default).
    without_statistics: ?bool = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .marker = "Marker",
        .max_records = "MaxRecords",
        .without_settings = "WithoutSettings",
        .without_statistics = "WithoutStatistics",
    };
};

pub const DescribeDataMigrationsOutput = struct {
    /// Returns information about the data migrations used in the project.
    data_migrations: ?[]const DataMigration = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is
    /// specified, the response includes only records beyond the marker, up to the
    /// value specified
    /// by `MaxRecords`.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_migrations = "DataMigrations",
        .marker = "Marker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDataMigrationsInput, options: CallOptions) !DescribeDataMigrationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDataMigrationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeDataMigrations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDataMigrationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDataMigrationsOutput, body, allocator);
}
