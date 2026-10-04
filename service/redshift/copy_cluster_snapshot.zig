const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Snapshot = @import("snapshot.zig").Snapshot;
const serde = @import("serde.zig");

pub const CopyClusterSnapshotInput = struct {
    /// The number of days that a manual snapshot is retained. If the value is -1,
    /// the manual
    /// snapshot is retained indefinitely.
    ///
    /// The value must be either -1 or an integer between 1 and 3,653.
    ///
    /// The default value is -1.
    manual_snapshot_retention_period: ?i32 = null,

    /// The identifier of the cluster the source snapshot was created from. This
    /// parameter
    /// is required if your IAM user has a policy containing a snapshot resource
    /// element that
    /// specifies anything other than * for the cluster name.
    ///
    /// Constraints:
    ///
    /// * Must be the identifier for a valid cluster.
    source_snapshot_cluster_identifier: ?[]const u8 = null,

    /// The identifier for the source snapshot.
    ///
    /// Constraints:
    ///
    /// * Must be the identifier for a valid automated snapshot whose state is
    /// `available`.
    source_snapshot_identifier: []const u8,

    /// The identifier given to the new manual snapshot.
    ///
    /// Constraints:
    ///
    /// * Cannot be null, empty, or blank.
    ///
    /// * Must contain from 1 to 255 alphanumeric characters or hyphens.
    ///
    /// * First character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    ///
    /// * Must be unique for the Amazon Web Services account that is making the
    ///   request.
    target_snapshot_identifier: []const u8,
};

pub const CopyClusterSnapshotOutput = struct {
    snapshot: ?Snapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyClusterSnapshotInput, options: CallOptions) !CopyClusterSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyClusterSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CopyClusterSnapshot&Version=2012-12-01");
    if (input.manual_snapshot_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&ManualSnapshotRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.source_snapshot_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SourceSnapshotClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&SourceSnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_snapshot_identifier);
    try body_buf.appendSlice(allocator, "&TargetSnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_snapshot_identifier);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyClusterSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CopyClusterSnapshotResult")) break;
            },
            else => {},
        }
    }

    var result: CopyClusterSnapshotOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Snapshot")) {
                    result.snapshot = try serde.deserializeSnapshot(allocator, &reader);
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
