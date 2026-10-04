const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBClusterSnapshotAttributesResult = @import("db_cluster_snapshot_attributes_result.zig").DBClusterSnapshotAttributesResult;
const serde = @import("serde.zig");

pub const ModifyDBClusterSnapshotAttributeInput = struct {
    /// The name of the cluster snapshot attribute to modify.
    ///
    /// To manage authorization for other Amazon Web Services accounts to copy or
    /// restore a manual cluster
    /// snapshot, set this value to `restore`.
    attribute_name: []const u8,

    /// The identifier for the cluster snapshot to modify the attributes for.
    db_cluster_snapshot_identifier: []const u8,

    /// A list of cluster snapshot attributes to add to the attribute specified by
    /// `AttributeName`.
    ///
    /// To authorize other Amazon Web Services accounts to copy or restore a manual
    /// cluster snapshot, set this list to include one or more Amazon Web Services
    /// account IDs. To make the manual cluster snapshot restorable by any Amazon
    /// Web Services account, set it to `all`. Do not add the `all` value for any
    /// manual cluster snapshots that contain private information that you don't
    /// want to be available to all Amazon Web Services accounts.
    values_to_add: ?[]const []const u8 = null,

    /// A list of cluster snapshot attributes to remove from the attribute specified
    /// by `AttributeName`.
    ///
    /// To remove authorization for other Amazon Web Services accounts to copy or
    /// restore a manual cluster snapshot, set this list to include one or more
    /// Amazon Web Services account identifiers. To remove authorization for any
    /// Amazon Web Services account to copy or restore the cluster snapshot, set it
    /// to `all` . If you specify `all`, an Amazon Web Services account whose
    /// account ID is explicitly added to the `restore` attribute can still copy or
    /// restore a manual cluster snapshot.
    values_to_remove: ?[]const []const u8 = null,
};

pub const ModifyDBClusterSnapshotAttributeOutput = struct {
    db_cluster_snapshot_attributes_result: ?DBClusterSnapshotAttributesResult = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBClusterSnapshotAttributeInput, options: CallOptions) !ModifyDBClusterSnapshotAttributeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBClusterSnapshotAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "DocDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBClusterSnapshotAttribute&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&AttributeName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.attribute_name);
    try body_buf.appendSlice(allocator, "&DBClusterSnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_snapshot_identifier);
    if (input.values_to_add) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ValuesToAdd.AttributeValue.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.values_to_remove) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ValuesToRemove.AttributeValue.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBClusterSnapshotAttributeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBClusterSnapshotAttributeResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBClusterSnapshotAttributeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterSnapshotAttributesResult")) {
                    result.db_cluster_snapshot_attributes_result = try serde.deserializeDBClusterSnapshotAttributesResult(allocator, &reader);
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
