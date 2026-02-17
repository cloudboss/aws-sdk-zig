const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const RegisteredInstance = @import("registered_instance.zig").RegisteredInstance;
const serde = @import("serde.zig");

pub const DescribeInstanceSqlHaHistoryStatesInput = struct {
    /// Checks whether you have the required permissions for the action,
    /// without actually making the request, and provides an error response. If you
    /// have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise,
    /// it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The end data and time of the period for which to get historical SQL Server
    /// High Availability
    /// states. If omitted, the API returns historical states up to the current
    /// date and time.
    ///
    /// Timezone: UTC
    ///
    /// Format: `YYYY-MM-DDThh:mm:ss.sssZ`
    end_time: ?i64 = null,

    /// One or more filters to apply to the results. Supported filters
    /// include:
    ///
    /// * `tag:` - The tag key and value pair assigned to the
    /// instance. For example, to find all instances tagged with `Owner:TeamA`,
    /// specify
    /// `tag:Owner` for the filter name and `TeamA` for the filter value.
    ///
    /// * `tag-key` - The tag key assigned to the instance.
    ///
    /// * `haStatus` - The SQL Server High Availability status of the SQL Server
    ///   High Availability instance (`processing` |
    /// `active` | `standby` | `invalid`).
    ///
    /// * `sqlServerLicenseUsage` - The license type for the SQL Server license
    /// (`full` | `waived`).
    filters: ?[]const Filter = null,

    /// The IDs of the SQL Server High Availability instances to describe. If
    /// omitted, the API returns
    /// historical states for all SQL Server High Availability instances.
    instance_ids: ?[]const []const u8 = null,

    /// The maximum number of results to return for the request in a
    /// single page. The remaining results can be seen by sending another request
    /// with the
    /// returned `nextToken` value.
    max_results: ?i32 = null,

    /// The token to use to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// The start data and time of the period for which to get the historical
    /// SQL Server High Availability states. If omitted, the API returns all
    /// available historical states.
    ///
    /// Timezone: UTC
    ///
    /// Format: `YYYY-MM-DDThh:mm:ss.sssZ`
    start_time: ?i64 = null,
};

pub const DescribeInstanceSqlHaHistoryStatesOutput = struct {
    /// Information about the historical SQL Server High Availability states of the
    /// SQL Server High Availability instances.
    instances: ?[]const RegisteredInstance = null,

    /// The token to use to retrieve the next page of results.
    /// This value is `null` when there are no more results to return.
    next_token: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeInstanceSqlHaHistoryStatesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeInstanceSqlHaHistoryStatesInput, options: Options) !DescribeInstanceSqlHaHistoryStatesOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeInstanceSqlHaHistoryStatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeInstanceSqlHaHistoryStates&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.end_time) |v| {
        try body_buf.appendSlice(alloc, "&EndTime=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.item.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.instance_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceIds.InstanceId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.start_time) |v| {
        try body_buf.appendSlice(alloc, "&StartTime=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeInstanceSqlHaHistoryStatesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeInstanceSqlHaHistoryStatesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "instanceSet")) {
                    result.instances = try serde.deserializeRegisteredInstanceList(&reader, alloc, "item");
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
