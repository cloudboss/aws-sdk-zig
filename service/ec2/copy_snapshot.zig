const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const Tag = @import("tag.zig").Tag;

/// Creates an exact copy of an Amazon EBS snapshot.
///
/// The location of the source snapshot determines whether you can copy it or
/// not,
/// and the allowed destinations for the snapshot copy.
///
/// * If the source snapshot is in a Region, you can copy it within that Region,
/// to another Region, to an Outpost associated with that Region, or to a Local
/// Zone in that Region.
///
/// * If the source snapshot is in a Local Zone, you can copy it within that
///   Local Zone,
/// to another Local Zone in the same zone group, or to the parent Region of the
/// Local
/// Zone.
///
/// * If the source snapshot is on an Outpost, you can't copy it.
///
/// When copying snapshots to a Region, the encryption outcome for the snapshot
/// copy depends on the
/// Amazon EBS encryption by default setting for the destination Region, the
/// encryption status of the source
/// snapshot, and the encryption parameters you specify in the request. For more
/// information, see [
/// Encryption and snapshot
/// copying](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-copy-snapshot.html#creating-encrypted-snapshots).
///
/// Snapshots copied to an Outpost must be encrypted. Unencrypted snapshots are
/// not supported
/// on Outposts. For more information, [
/// Amazon EBS local snapshots on
/// Outposts](https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html#considerations).
///
/// **Note:**
///
/// Snapshots copies have an arbitrary source volume ID. Do not use this volume
/// ID for
/// any purpose.
///
/// For more information, see [Copy an Amazon EBS
/// snapshot](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-copy-snapshot.html) in the
/// *Amazon EBS User Guide*.
pub const CopySnapshotInput = struct {
    /// **Note:**
    ///
    /// Not supported when copying snapshots to or from Local Zones or Outposts.
    ///
    /// Specify a completion duration, in 15 minute increments, to initiate a
    /// time-based snapshot
    /// copy. Time-based snapshot copy operations complete within the specified
    /// duration. For more
    /// information, see [
    /// Time-based
    /// copies](https://docs.aws.amazon.com/ebs/latest/userguide/time-based-copies.html).
    ///
    /// If you do not specify a value, the snapshot copy operation is completed on a
    /// best-effort basis.
    completion_duration_minutes: ?i32 = null,

    /// A description for the EBS snapshot.
    description: ?[]const u8 = null,

    /// The Local Zone, for example, `cn-north-1-pkx-1a` to which to copy the
    /// snapshot.
    ///
    /// **Note:**
    ///
    /// Only supported when copying a snapshot to a Local Zone.
    destination_availability_zone: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Outpost to which to copy the snapshot.
    ///
    /// **Note:**
    ///
    /// Only supported when copying a snapshot to an Outpost.
    ///
    /// For more information, see [
    /// Copy snapshots from an Amazon Web Services Region to an
    /// Outpost](https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html#copy-snapshots) in the
    /// *Amazon EBS User Guide*.
    destination_outpost_arn: ?[]const u8 = null,

    /// The destination Region to use in the `PresignedUrl` parameter of a snapshot
    /// copy operation. This parameter is only valid for specifying the destination
    /// Region in a
    /// `PresignedUrl` parameter, where it is required.
    ///
    /// The snapshot copy is sent to the regional endpoint that you sent the HTTP
    /// request to (for example, `ec2.us-east-1.amazonaws.com`). With the CLI, this
    /// is
    /// specified using the `--region` parameter or the default Region in your
    /// Amazon Web Services
    /// configuration file.
    destination_region: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// To encrypt a copy of an unencrypted snapshot if encryption by default is not
    /// enabled,
    /// enable encryption using this parameter. Otherwise, omit this parameter.
    /// Copies of encrypted
    /// snapshots are encrypted, even if you omit this parameter and encryption by
    /// default is not
    /// enabled. You cannot set this parameter to false. For more information, see
    /// [Amazon EBS
    /// encryption](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption.html) in the
    /// *Amazon EBS User Guide*.
    encrypted: ?bool = null,

    /// The identifier of the KMS key to use for Amazon EBS encryption.
    /// If this parameter is not specified, your KMS key for Amazon EBS is used. If
    /// `KmsKeyId` is
    /// specified, the encrypted state must be `true`.
    ///
    /// You can specify the KMS key using any of the following:
    ///
    /// * Key ID. For example, 1234abcd-12ab-34cd-56ef-1234567890ab.
    ///
    /// * Key alias. For example, alias/ExampleAlias.
    ///
    /// * Key ARN. For example,
    ///   arn:aws:kms:us-east-1:012345678910:key/1234abcd-12ab-34cd-56ef-1234567890ab.
    ///
    /// * Alias ARN. For example,
    ///   arn:aws:kms:us-east-1:012345678910:alias/ExampleAlias.
    ///
    /// Amazon Web Services authenticates the KMS key asynchronously. Therefore, if
    /// you specify an ID, alias, or ARN that is not valid,
    /// the action can appear to complete, but eventually fails.
    kms_key_id: ?[]const u8 = null,

    /// When you copy an encrypted source snapshot using the Amazon EC2 Query API,
    /// you must supply a
    /// pre-signed URL. This parameter is optional for unencrypted snapshots. For
    /// more information,
    /// see [Query
    /// requests](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html).
    ///
    /// The `PresignedUrl` should use the snapshot source endpoint, the
    /// `CopySnapshot` action, and include the `SourceRegion`,
    /// `SourceSnapshotId`, and `DestinationRegion` parameters. The
    /// `PresignedUrl` must be signed using Amazon Web Services Signature Version 4.
    /// Because EBS
    /// snapshots are stored in Amazon S3, the signing algorithm for this parameter
    /// uses the same logic
    /// that is described in [
    /// Authenticating Requests: Using Query Parameters (Amazon Web Services
    /// Signature Version
    /// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html) in the *Amazon S3 API Reference*. An
    /// invalid or improperly signed `PresignedUrl` will cause the copy operation to
    /// fail
    /// asynchronously, and the snapshot will move to an `error` state.
    presigned_url: ?[]const u8 = null,

    /// The ID of the Region that contains the snapshot to be copied.
    source_region: []const u8,

    /// The ID of the EBS snapshot to copy.
    source_snapshot_id: []const u8,

    /// The tags to apply to the new snapshot.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CopySnapshotOutput = struct {
    /// The ID of the new snapshot.
    snapshot_id: ?[]const u8 = null,

    /// Any tags applied to the new snapshot.
    tags: ?[]const Tag = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CopySnapshotOutput) void {
        if (self.snapshot_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CopySnapshotInput, options: Options) !CopySnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CopySnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CopySnapshot&Version=2016-11-15");
    if (input.completion_duration_minutes) |v| {
        try body_buf.appendSlice(alloc, "&CompletionDurationMinutes=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_availability_zone) |v| {
        try body_buf.appendSlice(alloc, "&DestinationAvailabilityZone=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_outpost_arn) |v| {
        try body_buf.appendSlice(alloc, "&DestinationOutpostArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_region) |v| {
        try body_buf.appendSlice(alloc, "&DestinationRegion=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.encrypted) |v| {
        try body_buf.appendSlice(alloc, "&Encrypted=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(alloc, "&KmsKeyId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.presigned_url) |v| {
        try body_buf.appendSlice(alloc, "&PresignedUrl=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&SourceRegion=");
    try appendUrlEncoded(alloc, &body_buf, input.source_region);
    try body_buf.appendSlice(alloc, "&SourceSnapshotId=");
    try appendUrlEncoded(alloc, &body_buf, input.source_snapshot_id);
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CopySnapshotOutput {
    _ = status;
    _ = headers;
    var result: CopySnapshotOutput = .{ .allocator = alloc };
    if (findElement(body, "snapshotId")) |content| {
        result.snapshot_id = try alloc.dupe(u8, content);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
