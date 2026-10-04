const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportSourceType = @import("export_source_type.zig").ExportSourceType;
const serde = @import("serde.zig");

pub const StartExportTaskInput = struct {
    /// The data to be exported from the snapshot or cluster. If this parameter
    /// isn't provided, all of the data is exported.
    ///
    /// Valid Values:
    ///
    /// * `database` - Export all the data from a specified database.
    /// * `database.table` *table-name* - Export a table of the snapshot or cluster.
    ///   This format is valid only for RDS for MySQL, RDS for MariaDB, and Aurora
    ///   MySQL.
    /// * `database.schema` *schema-name* - Export a database schema of the snapshot
    ///   or cluster. This format is valid only for RDS for PostgreSQL and Aurora
    ///   PostgreSQL.
    /// * `database.schema.table` *table-name* - Export a table of the database
    ///   schema. This format is valid only for RDS for PostgreSQL and Aurora
    ///   PostgreSQL.
    export_only: ?[]const []const u8 = null,

    /// A unique identifier for the export task. This ID isn't an identifier for the
    /// Amazon S3 bucket where the data is to be exported.
    export_task_identifier: []const u8,

    /// The name of the IAM role to use for writing to the Amazon S3 bucket when
    /// exporting a snapshot or cluster.
    ///
    /// In the IAM policy attached to your IAM role, include the following required
    /// actions to allow the transfer of files from Amazon RDS or Amazon Aurora to
    /// an S3 bucket:
    ///
    /// * s3:PutObject*
    /// * s3:GetObject*
    /// * s3:ListBucket
    /// * s3:DeleteObject*
    /// * s3:GetBucketLocation
    ///
    /// In the policy, include the resources to identify the S3 bucket and objects
    /// in the bucket. The following list of resources shows the Amazon Resource
    /// Name (ARN) format for accessing S3:
    ///
    /// * `arn:aws:s3:::*your-s3-bucket* `
    /// * `arn:aws:s3:::*your-s3-bucket*/*`
    iam_role_arn: []const u8,

    /// The ID of the Amazon Web Services KMS key to use to encrypt the data
    /// exported to Amazon S3. The Amazon Web Services KMS key identifier is the key
    /// ARN, key ID, alias ARN, or alias name for the KMS key. The caller of this
    /// operation must be authorized to run the following operations. These can be
    /// set in the Amazon Web Services KMS key policy:
    ///
    /// * kms:CreateGrant
    /// * kms:DescribeKey
    kms_key_id: []const u8,

    /// The name of the Amazon S3 bucket to export the snapshot or cluster data to.
    s3_bucket_name: []const u8,

    /// The Amazon S3 bucket prefix to use as the file name and path of the exported
    /// data.
    s3_prefix: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the snapshot or cluster to export to
    /// Amazon S3.
    source_arn: []const u8,
};

pub const StartExportTaskOutput = @import("export_task.zig").ExportTask;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartExportTaskInput, options: CallOptions) !StartExportTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartExportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=StartExportTask&Version=2014-10-31");
    if (input.export_only) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExportOnly.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    try body_buf.appendSlice(allocator, "&ExportTaskIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.export_task_identifier);
    try body_buf.appendSlice(allocator, "&IamRoleArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.iam_role_arn);
    try body_buf.appendSlice(allocator, "&KmsKeyId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.kms_key_id);
    try body_buf.appendSlice(allocator, "&S3BucketName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.s3_bucket_name);
    if (input.s3_prefix) |v| {
        try body_buf.appendSlice(allocator, "&S3Prefix=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&SourceArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartExportTaskOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StartExportTaskResult")) break;
            },
            else => {},
        }
    }

    var result: StartExportTaskOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExportOnly")) {
                    result.export_only = try serde.deserializeStringList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ExportTaskIdentifier")) {
                    result.export_task_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureCause")) {
                    result.failure_cause = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IamRoleArn")) {
                    result.iam_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PercentProgress")) {
                    result.percent_progress = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "S3Bucket")) {
                    result.s3_bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "S3Prefix")) {
                    result.s3_prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SnapshotTime")) {
                    result.snapshot_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SourceArn")) {
                    result.source_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceType")) {
                    result.source_type = ExportSourceType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TaskEndTime")) {
                    result.task_end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TaskStartTime")) {
                    result.task_start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TotalExtractedDataInGB")) {
                    result.total_extracted_data_in_gb = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "WarningMessage")) {
                    result.warning_message = try allocator.dupe(u8, try reader.readElementText());
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
