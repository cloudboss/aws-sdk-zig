const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DBClusterSnapshot = @import("db_cluster_snapshot.zig").DBClusterSnapshot;
const serde = @import("serde.zig");

pub const CopyDBClusterSnapshotInput = struct {
    /// True to copy all tags from the source DB cluster snapshot to the target DB
    /// cluster
    /// snapshot, and otherwise false. The default is false.
    copy_tags: ?bool = null,

    /// The Amazon KMS key ID for an encrypted DB cluster snapshot. The KMS key ID
    /// is the Amazon
    /// Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS
    /// encryption key.
    ///
    /// If you copy an encrypted DB cluster snapshot from your Amazon account, you
    /// can specify a
    /// value for `KmsKeyId` to encrypt the copy with a new KMS encryption key. If
    /// you
    /// don't specify a value for `KmsKeyId`, then the copy of the DB cluster
    /// snapshot is
    /// encrypted with the same KMS key as the source DB cluster snapshot.
    ///
    /// If you copy an encrypted DB cluster snapshot that is shared from another
    /// Amazon account, then
    /// you must specify a value for `KmsKeyId`.
    ///
    /// KMS encryption keys are specific to the Amazon Region that they are created
    /// in, and you
    /// can't use encryption keys from one Amazon Region in another Amazon Region.
    ///
    /// You cannot encrypt an unencrypted DB cluster snapshot when you copy it. If
    /// you try to
    /// copy an unencrypted DB cluster snapshot and specify a value for the KmsKeyId
    /// parameter, an
    /// error is returned.
    kms_key_id: ?[]const u8 = null,

    /// Not currently supported.
    pre_signed_url: ?[]const u8 = null,

    /// The identifier of the DB cluster snapshot to copy. This parameter is not
    /// case-sensitive. If the source DB cluster snapshot is in a different region
    /// or
    /// owned by another account, specify the snapshot ARN.
    ///
    /// Constraints:
    ///
    /// * Must specify a valid system snapshot in the "available" state.
    ///
    /// * Specify a valid DB snapshot identifier.
    ///
    /// Example: `my-cluster-snapshot1`
    source_db_cluster_snapshot_identifier: []const u8,

    /// The tags to assign to the new DB cluster snapshot copy.
    tags: ?[]const Tag = null,

    /// The identifier of the new DB cluster snapshot to create from the source DB
    /// cluster
    /// snapshot. This parameter is not case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens.
    ///
    /// * First character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `my-cluster-snapshot2`
    target_db_cluster_snapshot_identifier: []const u8,
};

pub const CopyDBClusterSnapshotOutput = struct {
    db_cluster_snapshot: ?DBClusterSnapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyDBClusterSnapshotInput, options: CallOptions) !CopyDBClusterSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyDBClusterSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CopyDBClusterSnapshot&Version=2014-10-31");
    if (input.copy_tags) |v| {
        try body_buf.appendSlice(allocator, "&CopyTags=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.pre_signed_url) |v| {
        try body_buf.appendSlice(allocator, "&PreSignedUrl=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&SourceDBClusterSnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_db_cluster_snapshot_identifier);
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
    try body_buf.appendSlice(allocator, "&TargetDBClusterSnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_db_cluster_snapshot_identifier);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyDBClusterSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CopyDBClusterSnapshotResult")) break;
            },
            else => {},
        }
    }

    var result: CopyDBClusterSnapshotOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterSnapshot")) {
                    result.db_cluster_snapshot = try serde.deserializeDBClusterSnapshot(allocator, &reader);
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
