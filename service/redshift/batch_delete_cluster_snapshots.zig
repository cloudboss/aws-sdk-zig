const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeleteClusterSnapshotMessage = @import("delete_cluster_snapshot_message.zig").DeleteClusterSnapshotMessage;
const SnapshotErrorMessage = @import("snapshot_error_message.zig").SnapshotErrorMessage;
const serde = @import("serde.zig");

pub const BatchDeleteClusterSnapshotsInput = struct {
    /// A list of identifiers for the snapshots that you want to delete.
    identifiers: []const DeleteClusterSnapshotMessage,
};

pub const BatchDeleteClusterSnapshotsOutput = struct {
    /// A list of any errors returned.
    errors: ?[]const SnapshotErrorMessage = null,

    /// A list of the snapshot identifiers that were deleted.
    resources: ?[]const []const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteClusterSnapshotsInput, options: CallOptions) !BatchDeleteClusterSnapshotsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteClusterSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=BatchDeleteClusterSnapshots&Version=2012-12-01");
    for (input.identifiers, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.snapshot_cluster_identifier) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Identifiers.DeleteClusterSnapshotMessage.{d}.SnapshotClusterIdentifier=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Identifiers.DeleteClusterSnapshotMessage.{d}.SnapshotIdentifier=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.snapshot_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteClusterSnapshotsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "BatchDeleteClusterSnapshotsResult")) break;
            },
            else => {},
        }
    }

    var result: BatchDeleteClusterSnapshotsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Errors")) {
                    result.errors = try serde.deserializeBatchSnapshotOperationErrorList(allocator, &reader, "SnapshotErrorMessage");
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
