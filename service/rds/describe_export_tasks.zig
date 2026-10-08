const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const ExportSourceType = @import("export_source_type.zig").ExportSourceType;
const ExportTask = @import("export_task.zig").ExportTask;
const serde = @import("serde.zig");

pub const DescribeExportTasksInput = struct {
    /// The identifier of the snapshot or cluster export task to be described.
    export_task_identifier: ?[]const u8 = null,

    /// Filters specify one or more snapshot or cluster exports to describe. The
    /// filters are specified as name-value pairs that define what to include in the
    /// output. Filter names and values are case-sensitive.
    ///
    /// Supported filters include the following:
    ///
    /// * `export-task-identifier` - An identifier for the snapshot or cluster
    ///   export task.
    /// * `s3-bucket` - The Amazon S3 bucket the data is exported to.
    /// * `source-arn` - The Amazon Resource Name (ARN) of the snapshot or cluster
    ///   exported to Amazon S3.
    /// * `status` - The status of the export task. Must be lowercase. Valid
    ///   statuses are the following:
    ///
    /// * `canceled`
    /// * `canceling`
    /// * `complete`
    /// * `failed`
    /// * `in_progress`
    /// * `starting`
    filters: ?[]const Filter = null,

    /// An optional pagination token provided by a previous `DescribeExportTasks`
    /// request. If you specify this parameter, the response includes only records
    /// beyond the marker, up to the value specified by the `MaxRecords` parameter.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified value, a pagination token called a marker is
    /// included in the response. You can use the marker in a later
    /// `DescribeExportTasks` request to retrieve the remaining results.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the snapshot or cluster exported to Amazon
    /// S3.
    source_arn: ?[]const u8 = null,

    /// The type of source for the export.
    source_type: ?ExportSourceType = null,
};

pub const DescribeExportTasksOutput = struct {
    /// Information about an export of a snapshot or cluster to Amazon S3.
    export_tasks: ?[]const ExportTask = null,

    /// A pagination token that can be used in a later `DescribeExportTasks`
    /// request. A marker is used for pagination to identify the location to begin
    /// output for the next response of `DescribeExportTasks`.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeExportTasksInput, options: CallOptions) !DescribeExportTasksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeExportTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeExportTasks&Version=2014-10-31");
    if (input.export_task_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ExportTaskIdentifier=");
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
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.source_arn) |v| {
        try body_buf.appendSlice(allocator, "&SourceArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source_type) |v| {
        try body_buf.appendSlice(allocator, "&SourceType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeExportTasksOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeExportTasksResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeExportTasksOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExportTasks")) {
                    result.export_tasks = try serde.deserializeExportTasksList(allocator, &reader, "ExportTask");
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
