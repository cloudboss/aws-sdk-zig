const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const DBInstanceAutomatedBackup = @import("db_instance_automated_backup.zig").DBInstanceAutomatedBackup;
const serde = @import("serde.zig");

pub const StartDBInstanceAutomatedBackupsReplicationInput = struct {
    /// The retention period for the replicated automated backups.
    backup_retention_period: ?i32 = null,

    /// The Amazon Web Services KMS key identifier for encryption of the replicated
    /// automated backups. The KMS key ID is the Amazon Resource Name (ARN) for the
    /// KMS encryption key in the destination Amazon Web Services Region, for
    /// example, `arn:aws:kms:us-east-1:123456789012:key/AKIAIOSFODNN7EXAMPLE`.
    kms_key_id: ?[]const u8 = null,

    /// In an Amazon Web Services GovCloud (US) Region, an URL that contains a
    /// Signature Version 4 signed request for the
    /// `StartDBInstanceAutomatedBackupsReplication` operation to call in the Amazon
    /// Web Services Region of the source DB instance. The presigned URL must be a
    /// valid request for the `StartDBInstanceAutomatedBackupsReplication` API
    /// operation that can run in the Amazon Web Services Region that contains the
    /// source DB instance.
    ///
    /// This setting applies only to Amazon Web Services GovCloud (US) Regions. It's
    /// ignored in other Amazon Web Services Regions.
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

    /// The Amazon Resource Name (ARN) of the source DB instance for the replicated
    /// automated backups, for example,
    /// `arn:aws:rds:us-west-2:123456789012:db:mydatabase`.
    source_db_instance_arn: []const u8,

    /// A list of tags to associate with the replicated automated backups.
    tags: ?[]const Tag = null,
};

pub const StartDBInstanceAutomatedBackupsReplicationOutput = struct {
    db_instance_automated_backup: ?DBInstanceAutomatedBackup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDBInstanceAutomatedBackupsReplicationInput, options: CallOptions) !StartDBInstanceAutomatedBackupsReplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDBInstanceAutomatedBackupsReplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=StartDBInstanceAutomatedBackupsReplication&Version=2014-10-31");
    if (input.backup_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&BackupRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.pre_signed_url) |v| {
        try body_buf.appendSlice(allocator, "&PreSignedUrl=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&SourceDBInstanceArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_db_instance_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDBInstanceAutomatedBackupsReplicationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StartDBInstanceAutomatedBackupsReplicationResult")) break;
            },
            else => {},
        }
    }

    var result: StartDBInstanceAutomatedBackupsReplicationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBInstanceAutomatedBackup")) {
                    result.db_instance_automated_backup = try serde.deserializeDBInstanceAutomatedBackup(allocator, &reader);
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
