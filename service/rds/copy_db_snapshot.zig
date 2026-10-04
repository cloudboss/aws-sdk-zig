const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DBSnapshot = @import("db_snapshot.zig").DBSnapshot;
const serde = @import("serde.zig");

pub const CopyDBSnapshotInput = struct {
    /// Specifies whether to copy the DB option group associated with the source DB
    /// snapshot to the target Amazon Web Services account and associate with the
    /// target DB snapshot. The associated option group can be copied only with
    /// cross-account snapshot copy calls.
    copy_option_group: ?bool = null,

    /// Specifies whether to copy all tags from the source DB snapshot to the target
    /// DB snapshot. By default, tags aren't copied.
    copy_tags: ?bool = null,

    /// The Amazon Web Services KMS key identifier for an encrypted DB snapshot. The
    /// Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or
    /// alias name for the KMS key.
    ///
    /// If you copy an encrypted DB snapshot from your Amazon Web Services account,
    /// you can specify a value for this parameter to encrypt the copy with a new
    /// KMS key. If you don't specify a value for this parameter, then the copy of
    /// the DB snapshot is encrypted with the same Amazon Web Services KMS key as
    /// the source DB snapshot.
    ///
    /// If you copy an encrypted DB snapshot that is shared from another Amazon Web
    /// Services account, then you must specify a value for this parameter.
    ///
    /// If you specify this parameter when you copy an unencrypted snapshot, the
    /// copy is encrypted.
    ///
    /// If you copy an encrypted snapshot to a different Amazon Web Services Region,
    /// then you must specify an Amazon Web Services KMS key identifier for the
    /// destination Amazon Web Services Region. KMS keys are specific to the Amazon
    /// Web Services Region that they are created in, and you can't use KMS keys
    /// from one Amazon Web Services Region in another Amazon Web Services Region.
    kms_key_id: ?[]const u8 = null,

    /// The name of an option group to associate with the copy of the snapshot.
    ///
    /// Specify this option if you are copying a snapshot from one Amazon Web
    /// Services Region to another, and your DB instance uses a nondefault option
    /// group. If your source DB instance uses Transparent Data Encryption for
    /// Oracle or Microsoft SQL Server, you must specify this option when copying
    /// across Amazon Web Services Regions. For more information, see [Option group
    /// considerations](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CopySnapshot.html#USER_CopySnapshot.Options) in the *Amazon RDS User Guide*.
    option_group_name: ?[]const u8 = null,

    /// When you are copying a snapshot from one Amazon Web Services GovCloud (US)
    /// Region to another, the URL that contains a Signature Version 4 signed
    /// request for the `CopyDBSnapshot` API operation in the source Amazon Web
    /// Services Region that contains the source DB snapshot to copy.
    ///
    /// This setting applies only to Amazon Web Services GovCloud (US) Regions. It's
    /// ignored in other Amazon Web Services Regions.
    ///
    /// You must specify this parameter when you copy an encrypted DB snapshot from
    /// another Amazon Web Services Region by using the Amazon RDS API. Don't
    /// specify `PreSignedUrl` when you are copying an encrypted DB snapshot in the
    /// same Amazon Web Services Region.
    ///
    /// The presigned URL must be a valid request for the `CopyDBClusterSnapshot`
    /// API operation that can run in the source Amazon Web Services Region that
    /// contains the encrypted DB cluster snapshot to copy. The presigned URL
    /// request must contain the following parameter values:
    ///
    /// * `DestinationRegion` - The Amazon Web Services Region that the encrypted DB
    ///   snapshot is copied to. This Amazon Web Services Region is the same one
    ///   where the `CopyDBSnapshot` operation is called that contains this
    ///   presigned URL.
    ///
    /// For example, if you copy an encrypted DB snapshot from the us-west-2 Amazon
    /// Web Services Region to the us-east-1 Amazon Web Services Region, then you
    /// call the `CopyDBSnapshot` operation in the us-east-1 Amazon Web Services
    /// Region and provide a presigned URL that contains a call to the
    /// `CopyDBSnapshot` operation in the us-west-2 Amazon Web Services Region. For
    /// this example, the `DestinationRegion` in the presigned URL must be set to
    /// the us-east-1 Amazon Web Services Region.
    /// * `KmsKeyId` - The KMS key identifier for the KMS key to use to encrypt the
    ///   copy of the DB snapshot in the destination Amazon Web Services Region.
    ///   This is the same identifier for both the `CopyDBSnapshot` operation that
    ///   is called in the destination Amazon Web Services Region, and the operation
    ///   contained in the presigned URL.
    /// * `SourceDBSnapshotIdentifier` - The DB snapshot identifier for the
    ///   encrypted snapshot to be copied. This identifier must be in the Amazon
    ///   Resource Name (ARN) format for the source Amazon Web Services Region. For
    ///   example, if you are copying an encrypted DB snapshot from the us-west-2
    ///   Amazon Web Services Region, then your `SourceDBSnapshotIdentifier` looks
    ///   like the following example:
    ///   `arn:aws:rds:us-west-2:123456789012:snapshot:mysql-instance1-snapshot-20161115`.
    ///
    /// To learn how to generate a Signature Version 4 signed request, see
    /// [Authenticating Requests: Using Query Parameters (Amazon Web Services
    /// Signature Version
    /// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html) and [Signature Version 4 Signing Process](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    ///
    /// If you are using an Amazon Web Services SDK tool or the CLI, you can specify
    /// `SourceRegion` (or `--source-region` for the CLI) instead of specifying
    /// `PreSignedUrl` manually. Specifying `SourceRegion` autogenerates a presigned
    /// URL that is a valid request for the operation that can run in the source
    /// Amazon Web Services Region.
    pre_signed_url: ?[]const u8 = null,

    /// Specifies the name of the Availability Zone where RDS stores the DB
    /// snapshot. This value is valid only for snapshots that RDS stores on a
    /// Dedicated Local Zone.
    snapshot_availability_zone: ?[]const u8 = null,

    /// Configures the location where RDS will store copied snapshots.
    ///
    /// Valid Values:
    ///
    /// * `local` (Dedicated Local Zone)
    /// * `outposts` (Amazon Web Services Outposts)
    /// * `region` (Amazon Web Services Region)
    snapshot_target: ?[]const u8 = null,

    /// The identifier for the source DB snapshot.
    ///
    /// If the source snapshot is in the same Amazon Web Services Region as the
    /// copy, specify a valid DB snapshot identifier. For example, you might specify
    /// `rds:mysql-instance1-snapshot-20130805`.
    ///
    /// If you are copying from a shared manual DB snapshot, this parameter must be
    /// the Amazon Resource Name (ARN) of the shared DB snapshot.
    ///
    /// If the source snapshot is in a different Amazon Web Services Region than the
    /// copy, specify a valid DB snapshot ARN. You can also specify an ARN of a
    /// snapshot that is in a different account and a different Amazon Web Services
    /// Region. For example, you might specify
    /// `arn:aws:rds:us-west-2:123456789012:snapshot:mysql-instance1-snapshot-20130805`.
    ///
    /// Constraints:
    ///
    /// * Must specify a valid source snapshot in the "available" state.
    ///
    /// Example: `rds:mydb-2012-04-02-00-01`
    ///
    /// Example:
    /// `arn:aws:rds:us-west-2:123456789012:snapshot:mysql-instance1-snapshot-20130805`
    source_db_snapshot_identifier: []const u8,

    tags: ?[]const Tag = null,

    /// The external custom Availability Zone (CAZ) identifier for the target CAZ.
    ///
    /// Example: `rds-caz-aiqhTgQv`.
    target_custom_availability_zone: ?[]const u8 = null,

    /// The identifier for the copy of the snapshot.
    ///
    /// Constraints:
    ///
    /// * Can't be null, empty, or blank
    /// * Must contain from 1 to 255 letters, numbers, or hyphens
    /// * First character must be a letter
    /// * Can't end with a hyphen or contain two consecutive hyphens
    ///
    /// Example: `my-db-snapshot`
    target_db_snapshot_identifier: []const u8,
};

pub const CopyDBSnapshotOutput = struct {
    db_snapshot: ?DBSnapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyDBSnapshotInput, options: CallOptions) !CopyDBSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyDBSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CopyDBSnapshot&Version=2014-10-31");
    if (input.copy_option_group) |v| {
        try body_buf.appendSlice(allocator, "&CopyOptionGroup=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.copy_tags) |v| {
        try body_buf.appendSlice(allocator, "&CopyTags=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.option_group_name) |v| {
        try body_buf.appendSlice(allocator, "&OptionGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.pre_signed_url) |v| {
        try body_buf.appendSlice(allocator, "&PreSignedUrl=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_availability_zone) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotAvailabilityZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_target) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotTarget=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&SourceDBSnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_db_snapshot_identifier);
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
    if (input.target_custom_availability_zone) |v| {
        try body_buf.appendSlice(allocator, "&TargetCustomAvailabilityZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&TargetDBSnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_db_snapshot_identifier);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyDBSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CopyDBSnapshotResult")) break;
            },
            else => {},
        }
    }

    var result: CopyDBSnapshotOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSnapshot")) {
                    result.db_snapshot = try serde.deserializeDBSnapshot(allocator, &reader);
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
