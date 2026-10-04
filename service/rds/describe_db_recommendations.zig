const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DBRecommendation = @import("db_recommendation.zig").DBRecommendation;
const serde = @import("serde.zig");

pub const DescribeDBRecommendationsInput = struct {
    /// A filter that specifies one or more recommendations to describe.
    ///
    /// Supported Filters:
    ///
    /// * `recommendation-id` - Accepts a list of recommendation identifiers. The
    ///   results list only includes the recommendations whose identifier is one of
    ///   the specified filter values.
    /// * `status` - Accepts a list of recommendation statuses.
    ///
    /// Valid values:
    ///
    /// * `active` - The recommendations which are ready for you to apply.
    /// * `pending` - The applied or scheduled recommendations which are in
    ///   progress.
    /// * `resolved` - The recommendations which are completed.
    /// * `dismissed` - The recommendations that you dismissed.
    ///
    /// The results list only includes the recommendations whose status is one of
    /// the specified filter values.
    /// * `severity` - Accepts a list of recommendation severities. The results list
    ///   only includes the recommendations whose severity is one of the specified
    ///   filter values.
    ///
    /// Valid values:
    ///
    /// * `high`
    /// * `medium`
    /// * `low`
    /// * `informational`
    ///
    /// * `type-id` - Accepts a list of recommendation type identifiers. The results
    ///   list only includes the recommendations whose type is one of the specified
    ///   filter values.
    /// * `dbi-resource-id` - Accepts a list of database resource identifiers. The
    ///   results list only includes the recommendations that generated for the
    ///   specified databases.
    /// * `cluster-resource-id` - Accepts a list of cluster resource identifiers.
    ///   The results list only includes the recommendations that generated for the
    ///   specified clusters.
    /// * `pg-arn` - Accepts a list of parameter group ARNs. The results list only
    ///   includes the recommendations that generated for the specified parameter
    ///   groups.
    /// * `cluster-pg-arn` - Accepts a list of cluster parameter group ARNs. The
    ///   results list only includes the recommendations that generated for the
    ///   specified cluster parameter groups.
    filters: ?[]const Filter = null,

    /// A filter to include only the recommendations that were updated after this
    /// specified time.
    last_updated_after: ?i64 = null,

    /// A filter to include only the recommendations that were updated before this
    /// specified time.
    last_updated_before: ?i64 = null,

    /// The language that you choose to return the list of recommendations.
    ///
    /// Valid values:
    ///
    /// * `en`
    /// * `en_UK`
    /// * `de`
    /// * `es`
    /// * `fr`
    /// * `id`
    /// * `it`
    /// * `ja`
    /// * `ko`
    /// * `pt_BR`
    /// * `zh_TW`
    /// * `zh_CN`
    locale: ?[]const u8 = null,

    /// An optional pagination token provided by a previous
    /// `DescribeDBRecommendations` request. If this parameter is specified, the
    /// response includes only records beyond the marker, up to the value specified
    /// by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of recommendations to include in the response. If more
    /// records exist than the specified `MaxRecords` value, a pagination token
    /// called a marker is included in the response so that you can retrieve the
    /// remaining results.
    max_records: ?i32 = null,
};

pub const DescribeDBRecommendationsOutput = struct {
    /// A list of recommendations which is returned from `DescribeDBRecommendations`
    /// API request.
    db_recommendations: ?[]const DBRecommendation = null,

    /// An optional pagination token provided by a previous
    /// `DBRecommendationsMessage` request. This token can be used later in a
    /// `DescribeDBRecomendations` request.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDBRecommendationsInput, options: CallOptions) !DescribeDBRecommendationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDBRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeDBRecommendations&Version=2014-10-31");
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
    if (input.last_updated_after) |v| {
        try body_buf.appendSlice(allocator, "&LastUpdatedAfter=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.last_updated_before) |v| {
        try body_buf.appendSlice(allocator, "&LastUpdatedBefore=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.locale) |v| {
        try body_buf.appendSlice(allocator, "&Locale=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDBRecommendationsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeDBRecommendationsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeDBRecommendationsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBRecommendations")) {
                    result.db_recommendations = try serde.deserializeDBRecommendationList(allocator, &reader, "member");
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
