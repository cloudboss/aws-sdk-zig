const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotErrorMessage = @import("snapshot_error_message.zig").SnapshotErrorMessage;
const serde = @import("serde.zig");

pub const BatchModifyClusterSnapshotsInput = struct {
    /// A boolean value indicating whether to override an exception if the retention
    /// period
    /// has passed.
    force: ?bool = null,

    /// The number of days that a manual snapshot is retained. If you specify the
    /// value -1,
    /// the manual snapshot is retained indefinitely.
    ///
    /// The number must be either -1 or an integer between 1 and 3,653.
    ///
    /// If you decrease the manual snapshot retention period from its current value,
    /// existing
    /// manual snapshots that fall outside of the new retention period will return
    /// an error. If
    /// you want to suppress the errors and delete the snapshots, use the force
    /// option.
    manual_snapshot_retention_period: ?i32 = null,

    /// A list of snapshot identifiers you want to modify.
    snapshot_identifier_list: []const []const u8,
};

pub const BatchModifyClusterSnapshotsOutput = struct {
    /// A list of any errors returned.
    errors: ?[]const SnapshotErrorMessage = null,

    /// A list of the snapshots that were modified.
    resources: ?[]const []const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchModifyClusterSnapshotsInput, options: CallOptions) !BatchModifyClusterSnapshotsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchModifyClusterSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=BatchModifyClusterSnapshots&Version=2012-12-01");
    if (input.force) |v| {
        try body_buf.appendSlice(allocator, "&Force=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.manual_snapshot_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&ManualSnapshotRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    for (input.snapshot_identifier_list, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SnapshotIdentifierList.String.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchModifyClusterSnapshotsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BatchModifyClusterSnapshotsResult")) break;
            },
            else => {},
        }
    }

    var result: BatchModifyClusterSnapshotsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Errors")) {
                    result.errors = try serde.deserializeBatchSnapshotOperationErrors(allocator, &reader, "SnapshotErrorMessage");
                } else if (std.mem.eql(u8, e.local, "Resources")) {
                    result.resources = try serde.deserializeSnapshotIdentifierList(allocator, &reader, "String");
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
