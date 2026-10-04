const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const ServerlessV2PlatformVersionInfo = @import("serverless_v2_platform_version_info.zig").ServerlessV2PlatformVersionInfo;
const serde = @import("serde.zig");

pub const DescribeServerlessV2PlatformVersionsInput = struct {
    /// Specifies whether to return only the default platform versions for each
    /// engine. The default platform version is the version used for new DB
    /// clusters.
    default_only: ?bool = null,

    /// The database engine to return platform version details for.
    ///
    /// Valid Values:
    ///
    /// * `aurora-mysql`
    /// * `aurora-postgresql`
    engine: ?[]const u8 = null,

    /// This parameter isn't currently supported.
    filters: ?[]const Filter = null,

    /// Specifies whether to also include platform versions which are no longer in
    /// use.
    include_all: ?bool = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more than the
    /// `MaxRecords` value is available, a pagination token called a marker is
    /// included in the response so you can retrieve the remaining results.
    ///
    /// Default: 20
    ///
    /// Constraints: Minimum 1, maximum 200.
    max_records: ?i32 = null,

    /// A specific platform version to return details for.
    ///
    /// Example: `3`
    serverless_v2_platform_version: ?[]const u8 = null,
};

pub const DescribeServerlessV2PlatformVersionsOutput = struct {
    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// A list of `ServerlessV2PlatformVersionInfo` elements.
    serverless_v2_platform_versions: ?[]const ServerlessV2PlatformVersionInfo = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeServerlessV2PlatformVersionsInput, options: CallOptions) !DescribeServerlessV2PlatformVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeServerlessV2PlatformVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeServerlessV2PlatformVersions&Version=2014-10-31");
    if (input.default_only) |v| {
        try body_buf.appendSlice(allocator, "&DefaultOnly=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.engine) |v| {
        try body_buf.appendSlice(allocator, "&Engine=");
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
    if (input.include_all) |v| {
        try body_buf.appendSlice(allocator, "&IncludeAll=");
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
    if (input.serverless_v2_platform_version) |v| {
        try body_buf.appendSlice(allocator, "&ServerlessV2PlatformVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeServerlessV2PlatformVersionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeServerlessV2PlatformVersionsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeServerlessV2PlatformVersionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessV2PlatformVersions")) {
                    result.serverless_v2_platform_versions = try serde.deserializeServerlessV2PlatformVersionList(allocator, &reader, "member");
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
