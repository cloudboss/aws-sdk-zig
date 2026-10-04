const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Snapshot = @import("snapshot.zig").Snapshot;
const serde = @import("serde.zig");

pub const CreateClusterSnapshotInput = struct {
    /// The cluster identifier for which you want a snapshot.
    cluster_identifier: []const u8,

    /// The number of days that a manual snapshot is retained. If the value is -1,
    /// the manual
    /// snapshot is retained indefinitely.
    ///
    /// The value must be either -1 or an integer between 1 and 3,653.
    ///
    /// The default value is -1.
    manual_snapshot_retention_period: ?i32 = null,

    /// A unique identifier for the snapshot that you are requesting. This
    /// identifier must
    /// be unique for all snapshots within the Amazon Web Services account.
    ///
    /// Constraints:
    ///
    /// * Cannot be null, empty, or blank
    ///
    /// * Must contain from 1 to 255 alphanumeric characters or hyphens
    ///
    /// * First character must be a letter
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens
    ///
    /// Example: `my-snapshot-id`
    snapshot_identifier: []const u8,

    /// A list of tag instances.
    tags: ?[]const Tag = null,
};

pub const CreateClusterSnapshotOutput = struct {
    snapshot: ?Snapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterSnapshotInput, options: CallOptions) !CreateClusterSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateClusterSnapshot&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    if (input.manual_snapshot_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&ManualSnapshotRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&SnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.snapshot_identifier);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateClusterSnapshotResult")) break;
            },
            else => {},
        }
    }

    var result: CreateClusterSnapshotOutput = .{};
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
