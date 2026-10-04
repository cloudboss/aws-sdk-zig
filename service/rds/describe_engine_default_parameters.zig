const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const EngineDefaults = @import("engine_defaults.zig").EngineDefaults;
const serde = @import("serde.zig");

pub const DescribeEngineDefaultParametersInput = struct {
    /// The name of the DB parameter group family.
    ///
    /// Valid Values:
    ///
    /// * `aurora-mysql5.7`
    /// * `aurora-mysql8.0`
    /// * `aurora-postgresql10`
    /// * `aurora-postgresql11`
    /// * `aurora-postgresql12`
    /// * `aurora-postgresql13`
    /// * `aurora-postgresql14`
    /// * `custom-oracle-ee-19`
    /// * `custom-oracle-ee-cdb-19`
    /// * `db2-ae`
    /// * `db2-ce`
    /// * `db2-se`
    /// * `mariadb10.2`
    /// * `mariadb10.3`
    /// * `mariadb10.4`
    /// * `mariadb10.5`
    /// * `mariadb10.6`
    /// * `mysql5.7`
    /// * `mysql8.0`
    /// * `oracle-ee-19`
    /// * `oracle-ee-cdb-19`
    /// * `oracle-ee-cdb-21`
    /// * `oracle-se2-19`
    /// * `oracle-se2-cdb-19`
    /// * `oracle-se2-cdb-21`
    /// * `postgres10`
    /// * `postgres11`
    /// * `postgres12`
    /// * `postgres13`
    /// * `postgres14`
    /// * `sqlserver-ee-11.0`
    /// * `sqlserver-ee-12.0`
    /// * `sqlserver-ee-13.0`
    /// * `sqlserver-ee-14.0`
    /// * `sqlserver-ee-15.0`
    /// * `sqlserver-ex-11.0`
    /// * `sqlserver-ex-12.0`
    /// * `sqlserver-ex-13.0`
    /// * `sqlserver-ex-14.0`
    /// * `sqlserver-ex-15.0`
    /// * `sqlserver-se-11.0`
    /// * `sqlserver-se-12.0`
    /// * `sqlserver-se-13.0`
    /// * `sqlserver-se-14.0`
    /// * `sqlserver-se-15.0`
    /// * `sqlserver-web-11.0`
    /// * `sqlserver-web-12.0`
    /// * `sqlserver-web-13.0`
    /// * `sqlserver-web-14.0`
    /// * `sqlserver-web-15.0`
    db_parameter_group_family: []const u8,

    /// A filter that specifies one or more parameters to describe.
    ///
    /// The only supported filter is `parameter-name`. The results list only
    /// includes information about the parameters with these names.
    filters: ?[]const Filter = null,

    /// An optional pagination token provided by a previous
    /// `DescribeEngineDefaultParameters` request. If this parameter is specified,
    /// the response includes only records beyond the marker, up to the value
    /// specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified `MaxRecords` value, a pagination token called a
    /// marker is included in the response so you can retrieve the remaining
    /// results.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,
};

pub const DescribeEngineDefaultParametersOutput = struct {
    engine_defaults: ?EngineDefaults = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEngineDefaultParametersInput, options: CallOptions) !DescribeEngineDefaultParametersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEngineDefaultParametersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEngineDefaultParameters&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBParameterGroupFamily=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_parameter_group_family);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEngineDefaultParametersOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeEngineDefaultParametersResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeEngineDefaultParametersOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EngineDefaults")) {
                    result.engine_defaults = try serde.deserializeEngineDefaults(allocator, &reader);
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
