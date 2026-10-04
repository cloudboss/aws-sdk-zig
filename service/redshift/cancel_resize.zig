const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const CancelResizeInput = struct {
    /// The unique identifier for the cluster that you want to cancel a resize
    /// operation
    /// for.
    cluster_identifier: []const u8,
};

pub const CancelResizeOutput = struct {
    /// The average rate of the resize operation over the last few minutes, measured
    /// in
    /// megabytes per second. After the resize operation completes, this value shows
    /// the average
    /// rate of the entire resize operation.
    avg_resize_rate_in_mega_bytes_per_second: ?f64 = null,

    /// The percent of data transferred from source cluster to target cluster.
    data_transfer_progress_percent: ?f64 = null,

    /// The amount of seconds that have elapsed since the resize operation began.
    /// After the
    /// resize operation completes, this value shows the total actual time, in
    /// seconds, for the
    /// resize operation.
    elapsed_time_in_seconds: ?i64 = null,

    /// The estimated time remaining, in seconds, until the resize operation is
    /// complete.
    /// This value is calculated based on the average resize rate and the estimated
    /// amount of
    /// data remaining to be processed. Once the resize operation is complete, this
    /// value will
    /// be 0.
    estimated_time_to_completion_in_seconds: ?i64 = null,

    /// The names of tables that have been completely imported .
    ///
    /// Valid Values: List of table names.
    import_tables_completed: ?[]const []const u8 = null,

    /// The names of tables that are being currently imported.
    ///
    /// Valid Values: List of table names.
    import_tables_in_progress: ?[]const []const u8 = null,

    /// The names of tables that have not been yet imported.
    ///
    /// Valid Values: List of table names
    import_tables_not_started: ?[]const []const u8 = null,

    /// An optional string to provide additional details about the resize action.
    message: ?[]const u8 = null,

    /// While the resize operation is in progress, this value shows the current
    /// amount of
    /// data, in megabytes, that has been processed so far. When the resize
    /// operation is
    /// complete, this value shows the total amount of data, in megabytes, on the
    /// cluster, which
    /// may be more or less than TotalResizeDataInMegaBytes (the estimated total
    /// amount of data
    /// before resize).
    progress_in_mega_bytes: ?i64 = null,

    /// An enum with possible values of `ClassicResize` and
    /// `ElasticResize`. These values describe the type of resize operation being
    /// performed.
    resize_type: ?[]const u8 = null,

    /// The status of the resize operation.
    ///
    /// Valid Values: `NONE` | `IN_PROGRESS` | `FAILED` |
    /// `SUCCEEDED` | `CANCELLING`
    status: ?[]const u8 = null,

    /// The cluster type after the resize operation is complete.
    ///
    /// Valid Values: `multi-node` | `single-node`
    target_cluster_type: ?[]const u8 = null,

    /// The type of encryption for the cluster after the resize is complete.
    ///
    /// Possible values are `KMS` and `None`.
    target_encryption_type: ?[]const u8 = null,

    /// The node type that the cluster will have after the resize operation is
    /// complete.
    target_node_type: ?[]const u8 = null,

    /// The number of nodes that the cluster will have after the resize operation is
    /// complete.
    target_number_of_nodes: ?i32 = null,

    /// The estimated total amount of data, in megabytes, on the cluster before the
    /// resize
    /// operation began.
    total_resize_data_in_mega_bytes: ?i64 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelResizeInput, options: CallOptions) !CancelResizeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelResizeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CancelResize&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelResizeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CancelResizeResult")) break;
            },
            else => {},
        }
    }

    var result: CancelResizeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvgResizeRateInMegaBytesPerSecond")) {
                    result.avg_resize_rate_in_mega_bytes_per_second = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DataTransferProgressPercent")) {
                    result.data_transfer_progress_percent = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ElapsedTimeInSeconds")) {
                    result.elapsed_time_in_seconds = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "EstimatedTimeToCompletionInSeconds")) {
                    result.estimated_time_to_completion_in_seconds = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ImportTablesCompleted")) {
                    result.import_tables_completed = try serde.deserializeImportTablesCompleted(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ImportTablesInProgress")) {
                    result.import_tables_in_progress = try serde.deserializeImportTablesInProgress(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ImportTablesNotStarted")) {
                    result.import_tables_not_started = try serde.deserializeImportTablesNotStarted(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProgressInMegaBytes")) {
                    result.progress_in_mega_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResizeType")) {
                    result.resize_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetClusterType")) {
                    result.target_cluster_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetEncryptionType")) {
                    result.target_encryption_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetNodeType")) {
                    result.target_node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetNumberOfNodes")) {
                    result.target_number_of_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TotalResizeDataInMegaBytes")) {
                    result.total_resize_data_in_mega_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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
