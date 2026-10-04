const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Cluster = @import("cluster.zig").Cluster;
const serde = @import("serde.zig");

pub const ModifySnapshotCopyRetentionPeriodInput = struct {
    /// The unique identifier of the cluster for which you want to change the
    /// retention
    /// period for either automated or manual snapshots that are copied to a
    /// destination Amazon Web Services Region.
    ///
    /// Constraints: Must be the valid name of an existing cluster that has
    /// cross-region
    /// snapshot copy enabled.
    cluster_identifier: []const u8,

    /// Indicates whether to apply the snapshot retention period to newly copied
    /// manual
    /// snapshots instead of automated snapshots.
    manual: ?bool = null,

    /// The number of days to retain automated snapshots in the destination Amazon
    /// Web Services Region
    /// after they are copied from the source Amazon Web Services Region.
    ///
    /// By default, this only changes the retention period of copied automated
    /// snapshots.
    ///
    /// If you decrease the retention period for automated snapshots that are copied
    /// to a
    /// destination Amazon Web Services Region, Amazon Redshift deletes any existing
    /// automated snapshots that were
    /// copied to the destination Amazon Web Services Region and that fall outside
    /// of the new retention
    /// period.
    ///
    /// Constraints: Must be at least 1 and no more than 35 for automated snapshots.
    ///
    /// If you specify the `manual` option, only newly copied manual snapshots will
    /// have the new retention period.
    ///
    /// If you specify the value of -1 newly copied manual snapshots are retained
    /// indefinitely.
    ///
    /// Constraints: The number of days must be either -1 or an integer between 1
    /// and 3,653
    /// for manual snapshots.
    retention_period: i32,
};

pub const ModifySnapshotCopyRetentionPeriodOutput = struct {
    cluster: ?Cluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifySnapshotCopyRetentionPeriodInput, options: CallOptions) !ModifySnapshotCopyRetentionPeriodOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifySnapshotCopyRetentionPeriodInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifySnapshotCopyRetentionPeriod&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    if (input.manual) |v| {
        try body_buf.appendSlice(allocator, "&Manual=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&RetentionPeriod=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.retention_period}) catch "");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifySnapshotCopyRetentionPeriodOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifySnapshotCopyRetentionPeriodResult")) break;
            },
            else => {},
        }
    }

    var result: ModifySnapshotCopyRetentionPeriodOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Cluster")) {
                    result.cluster = try serde.deserializeCluster(allocator, &reader);
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
