const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DBClusterSnapshot = @import("db_cluster_snapshot.zig").DBClusterSnapshot;
const serde = @import("serde.zig");

pub const CopyDBClusterSnapshotInput = struct {
    /// Specifies whether to copy all tags from the source DB cluster snapshot to
    /// the target DB cluster snapshot. By default, tags are not copied.
    copy_tags: ?bool = null,

    /// The Amazon Web Services KMS key identifier for an encrypted DB cluster
    /// snapshot. The Amazon Web Services KMS key identifier is the key ARN, key ID,
    /// alias ARN, or alias name for the Amazon Web Services KMS key.
    ///
    /// If you copy an encrypted DB cluster snapshot from your Amazon Web Services
    /// account, you can specify a value for `KmsKeyId` to encrypt the copy with a
    /// new KMS key. If you don't specify a value for `KmsKeyId`, then the copy of
    /// the DB cluster snapshot is encrypted with the same KMS key as the source DB
    /// cluster snapshot.
    ///
    /// If you copy an encrypted DB cluster snapshot that is shared from another
    /// Amazon Web Services account, then you must specify a value for `KmsKeyId`.
    ///
    /// To copy an encrypted DB cluster snapshot to another Amazon Web Services
    /// Region, you must set `KmsKeyId` to the Amazon Web Services KMS key
    /// identifier you want to use to encrypt the copy of the DB cluster snapshot in
    /// the destination Amazon Web Services Region. KMS keys are specific to the
    /// Amazon Web Services Region that they are created in, and you can't use KMS
    /// keys from one Amazon Web Services Region in another Amazon Web Services
    /// Region.
    ///
    /// If you copy an unencrypted DB cluster snapshot and specify a value for the
    /// `KmsKeyId` parameter, an error is returned.
    kms_key_id: ?[]const u8 = null,

    /// When you are copying a DB cluster snapshot from one Amazon Web Services
    /// GovCloud (US) Region to another, the URL that contains a Signature Version 4
    /// signed request for the `CopyDBClusterSnapshot` API operation in the Amazon
    /// Web Services Region that contains the source DB cluster snapshot to copy.
    /// Use the `PreSignedUrl` parameter when copying an encrypted DB cluster
    /// snapshot from another Amazon Web Services Region. Don't specify
    /// `PreSignedUrl` when copying an encrypted DB cluster snapshot in the same
    /// Amazon Web Services Region.
    ///
    /// This setting applies only to Amazon Web Services GovCloud (US) Regions. It's
    /// ignored in other Amazon Web Services Regions.
    ///
    /// The presigned URL must be a valid request for the `CopyDBClusterSnapshot`
    /// API operation that can run in the source Amazon Web Services Region that
    /// contains the encrypted DB cluster snapshot to copy. The presigned URL
    /// request must contain the following parameter values:
    ///
    /// * `KmsKeyId` - The KMS key identifier for the KMS key to use to encrypt the
    ///   copy of the DB cluster snapshot in the destination Amazon Web Services
    ///   Region. This is the same identifier for both the `CopyDBClusterSnapshot`
    ///   operation that is called in the destination Amazon Web Services Region,
    ///   and the operation contained in the presigned URL.
    /// * `DestinationRegion` - The name of the Amazon Web Services Region that the
    ///   DB cluster snapshot is to be created in.
    /// * `SourceDBClusterSnapshotIdentifier` - The DB cluster snapshot identifier
    ///   for the encrypted DB cluster snapshot to be copied. This identifier must
    ///   be in the Amazon Resource Name (ARN) format for the source Amazon Web
    ///   Services Region. For example, if you are copying an encrypted DB cluster
    ///   snapshot from the us-west-2 Amazon Web Services Region, then your
    ///   `SourceDBClusterSnapshotIdentifier` looks like the following example:
    ///   `arn:aws:rds:us-west-2:123456789012:cluster-snapshot:aurora-cluster1-snapshot-20161115`.
    ///
    /// To learn how to generate a Signature Version 4 signed request, see [
    /// Authenticating Requests: Using Query Parameters (Amazon Web Services
    /// Signature Version
    /// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html) and [ Signature Version 4 Signing Process](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    ///
    /// If you are using an Amazon Web Services SDK tool or the CLI, you can specify
    /// `SourceRegion` (or `--source-region` for the CLI) instead of specifying
    /// `PreSignedUrl` manually. Specifying `SourceRegion` autogenerates a presigned
    /// URL that is a valid request for the operation that can run in the source
    /// Amazon Web Services Region.
    pre_signed_url: ?[]const u8 = null,

    /// The identifier of the DB cluster snapshot to copy. This parameter isn't
    /// case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must specify a valid source snapshot in the "available" state.
    /// * If the source snapshot is in the same Amazon Web Services Region as the
    ///   copy, specify a valid DB snapshot identifier.
    /// * If the source snapshot is in a different Amazon Web Services Region than
    ///   the copy, specify a valid DB cluster snapshot ARN. You can also specify an
    ///   ARN of a snapshot that is in a different account and a different Amazon
    ///   Web Services Region. For more information, go to [ Copying Snapshots
    ///   Across Amazon Web Services
    ///   Regions](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_CopySnapshot.html#USER_CopySnapshot.AcrossRegions) in the *Amazon Aurora User Guide*.
    ///
    /// Example: `my-cluster-snapshot1`
    source_db_cluster_snapshot_identifier: []const u8,

    tags: ?[]const Tag = null,

    /// The identifier of the new DB cluster snapshot to create from the source DB
    /// cluster snapshot. This parameter isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 letters, numbers, or hyphens.
    /// * First character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
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
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

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
