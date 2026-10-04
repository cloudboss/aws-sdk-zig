const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Cluster = @import("cluster.zig").Cluster;
const serde = @import("serde.zig");

pub const EnableSnapshotCopyInput = struct {
    /// The unique identifier of the source cluster to copy snapshots from.
    ///
    /// Constraints: Must be the valid name of an existing cluster that does not
    /// already
    /// have cross-region snapshot copy enabled.
    cluster_identifier: []const u8,

    /// The destination Amazon Web Services Region that you want to copy snapshots
    /// to.
    ///
    /// Constraints: Must be the name of a valid Amazon Web Services Region. For
    /// more information, see
    /// [Regions and
    /// Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#redshift_region) in the Amazon Web Services General Reference.
    destination_region: []const u8,

    /// The number of days to retain newly copied snapshots in the destination
    /// Amazon Web Services Region
    /// after they are copied from the source Amazon Web Services Region. If the
    /// value is -1, the manual
    /// snapshot is retained indefinitely.
    ///
    /// The value must be either -1 or an integer between 1 and 3,653.
    manual_snapshot_retention_period: ?i32 = null,

    /// The number of days to retain automated snapshots in the destination region
    /// after
    /// they are copied from the source region.
    ///
    /// Default: 7.
    ///
    /// Constraints: Must be at least 1 and no more than 35.
    retention_period: ?i32 = null,

    /// The name of the snapshot copy grant to use when snapshots of an Amazon Web
    /// Services KMS-encrypted
    /// cluster are copied to the destination region.
    snapshot_copy_grant_name: ?[]const u8 = null,
};

pub const EnableSnapshotCopyOutput = struct {
    cluster: ?Cluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableSnapshotCopyInput, options: CallOptions) !EnableSnapshotCopyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableSnapshotCopyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=EnableSnapshotCopy&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    try body_buf.appendSlice(allocator, "&DestinationRegion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.destination_region);
    if (input.manual_snapshot_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&ManualSnapshotRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.retention_period) |v| {
        try body_buf.appendSlice(allocator, "&RetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.snapshot_copy_grant_name) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotCopyGrantName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableSnapshotCopyOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EnableSnapshotCopyResult")) break;
            },
            else => {},
        }
    }

    var result: EnableSnapshotCopyOutput = .{};
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
