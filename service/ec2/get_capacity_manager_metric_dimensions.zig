const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CapacityManagerCondition = @import("capacity_manager_condition.zig").CapacityManagerCondition;
const GroupBy = @import("group_by.zig").GroupBy;
const Metric = @import("metric.zig").Metric;
const CapacityManagerDimension = @import("capacity_manager_dimension.zig").CapacityManagerDimension;
const serde = @import("serde.zig");

pub const GetCapacityManagerMetricDimensionsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides
    /// an error response. If you have the required permissions, the error response
    /// is `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The end time for the dimension query, in ISO 8601 format. Only dimensions
    /// with data in this time range will be returned.
    end_time: i64,

    /// Conditions to filter which dimension values are returned. Each filter
    /// specifies a dimension, comparison operator, and values to match against.
    filter_by: ?[]const CapacityManagerCondition = null,

    /// The dimensions to group by when retrieving available dimension values. This
    /// determines which dimension combinations are returned. Required parameter.
    group_by: []const GroupBy,

    /// The maximum number of dimension combinations to return. Valid range is 1 to
    /// 1000. Use with NextToken for pagination.
    max_results: ?i32 = null,

    /// The metric names to use as an additional filter when retrieving dimensions.
    /// Only dimensions that have data for these
    /// metrics will be returned. Required parameter with maximum size of 1 for v1.
    metric_names: []const Metric,

    /// The token for the next page of results. Use this value in a subsequent call
    /// to retrieve additional dimension values.
    next_token: ?[]const u8 = null,

    /// The start time for the dimension query, in ISO 8601 format. Only dimensions
    /// with data in this time range will be returned.
    start_time: i64,
};

pub const GetCapacityManagerMetricDimensionsOutput = struct {
    /// The available dimension combinations that have data within the specified
    /// time range and filters.
    metric_dimension_results: ?[]const CapacityManagerDimension = null,

    /// The token to use to retrieve the next page of results. This value is null
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetCapacityManagerMetricDimensionsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetCapacityManagerMetricDimensionsInput, options: Options) !GetCapacityManagerMetricDimensionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetCapacityManagerMetricDimensionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetCapacityManagerMetricDimensions&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&EndTime=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.end_time}) catch "");
    if (input.filter_by) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.dimension_condition) |sv_1| {
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&FilterBy.item.{d}.DimensionCondition.Comparison=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.comparison) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&FilterBy.item.{d}.DimensionCondition.Dimension=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (sv_1.dimension) |fv_2| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_2));
                    }
                }
                if (sv_1.values) |lst_2| {
                    for (lst_2, 0..) |item_2, idx_2| {
                        const n_2 = idx_2 + 1;
                        {
                            var prefix_buf: [256]u8 = undefined;
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&FilterBy.item.{d}.DimensionCondition.Values.item.{d}=", .{n, n_2}) catch continue;
                            try body_buf.appendSlice(alloc, field_prefix);
                            try aws.url.appendUrlEncoded(alloc, &body_buf, item_2);
                        }
                    }
                }
            }
        }
    }
    for (input.group_by, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&GroupBy.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    for (input.metric_names, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricName.item.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&StartTime=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.start_time}) catch "");

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetCapacityManagerMetricDimensionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetCapacityManagerMetricDimensionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "metricDimensionResultSet")) {
                    result.metric_dimension_results = try serde.deserializeMetricDimensionResultSet(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, request_id);
    errdefer alloc.free(owned_request_id);


    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
