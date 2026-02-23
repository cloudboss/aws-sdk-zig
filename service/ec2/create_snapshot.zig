const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SnapshotLocationEnum = @import("snapshot_location_enum.zig").SnapshotLocationEnum;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const SSEType = @import("sse_type.zig").SSEType;
const SnapshotState = @import("snapshot_state.zig").SnapshotState;
const StorageTier = @import("storage_tier.zig").StorageTier;
const Tag = @import("tag.zig").Tag;
const TransferType = @import("transfer_type.zig").TransferType;
const serde = @import("serde.zig");

pub const CreateSnapshotInput = struct {
    /// A description for the snapshot.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Only supported for volumes in Local Zones. If the source volume is not in a
    /// Local Zone,
    /// omit this parameter.
    ///
    /// * To create a local snapshot in the same Local Zone as the source volume,
    ///   specify
    /// `local`.
    ///
    /// * To create a regional snapshot in the parent Region of the Local Zone,
    ///   specify
    /// `regional` or omit this parameter.
    ///
    /// Default value: `regional`
    location: ?SnapshotLocationEnum = null,

    /// Only supported for volumes on Outposts. If the source volume is not on an
    /// Outpost,
    /// omit this parameter.
    ///
    /// * To create the snapshot on the same Outpost as the source volume, specify
    ///   the
    /// ARN of that Outpost. The snapshot must be created on the same Outpost as the
    /// volume.
    ///
    /// * To create the snapshot in the parent Region of the Outpost, omit this
    ///   parameter.
    ///
    /// For more information, see [Create local snapshots from volumes on an
    /// Outpost](https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html#create-snapshot) in the *Amazon EBS User Guide*.
    outpost_arn: ?[]const u8 = null,

    /// The tags to apply to the snapshot during creation.
    tag_specifications: ?[]const TagSpecification = null,

    /// The ID of the Amazon EBS volume.
    volume_id: []const u8,
};

pub const CreateSnapshotOutput = struct {
    /// The Availability Zone or Local Zone of the snapshot. For example,
    /// `us-west-1a`
    /// (Availability Zone) or `us-west-2-lax-1a` (Local Zone).
    availability_zone: ?[]const u8 = null,

    /// Only for snapshot copies created with time-based snapshot copy operations.
    ///
    /// The completion duration requested for the time-based snapshot copy
    /// operation.
    completion_duration_minutes: ?i32 = null,

    /// The time stamp when the snapshot was completed.
    completion_time: ?i64 = null,

    /// The data encryption key identifier for the snapshot. This value is a unique
    /// identifier
    /// that corresponds to the data encryption key that was used to encrypt the
    /// original volume or
    /// snapshot copy. Because data encryption keys are inherited by volumes created
    /// from snapshots,
    /// and vice versa, if snapshots share the same data encryption key identifier,
    /// then they belong
    /// to the same volume/snapshot lineage. This parameter is only returned by
    /// DescribeSnapshots.
    data_encryption_key_id: ?[]const u8 = null,

    /// The description for the snapshot.
    description: ?[]const u8 = null,

    /// Indicates whether the snapshot is encrypted.
    encrypted: ?bool = null,

    /// The full size of the snapshot, in bytes.
    ///
    /// This is **not** the incremental size of the snapshot.
    /// This is the full snapshot size and represents the size of all the blocks
    /// that were
    /// written to the source volume at the time the snapshot was created.
    full_snapshot_size_in_bytes: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the KMS key that was used to protect the
    /// volume encryption key for the parent volume.
    kms_key_id: ?[]const u8 = null,

    /// The ARN of the Outpost on which the snapshot is stored. For more
    /// information, see [Amazon EBS local snapshots on
    /// Outposts](https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html) in the
    /// *Amazon EBS User Guide*.
    outpost_arn: ?[]const u8 = null,

    /// The Amazon Web Services owner alias, from an Amazon-maintained list
    /// (`amazon`). This is not
    /// the user-configured Amazon Web Services account alias set using the IAM
    /// console.
    owner_alias: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the EBS snapshot.
    owner_id: ?[]const u8 = null,

    /// The progress of the snapshot, as a percentage.
    progress: ?[]const u8 = null,

    /// Only for archived snapshots that are temporarily restored. Indicates the
    /// date and
    /// time when a temporarily restored snapshot will be automatically re-archived.
    restore_expiry_time: ?i64 = null,

    /// The ID of the snapshot. Each snapshot receives a unique identifier when it
    /// is
    /// created.
    snapshot_id: ?[]const u8 = null,

    /// Reserved for future use.
    sse_type: ?SSEType = null,

    /// The time stamp when the snapshot was initiated.
    start_time: ?i64 = null,

    /// The snapshot state.
    state: ?SnapshotState = null,

    /// Encrypted Amazon EBS snapshots are copied asynchronously. If a snapshot copy
    /// operation fails
    /// (for example, if the proper KMS permissions are not obtained) this field
    /// displays error
    /// state details to help you diagnose why the error occurred. This parameter is
    /// only returned by
    /// DescribeSnapshots.
    state_message: ?[]const u8 = null,

    /// The storage tier in which the snapshot is stored. `standard` indicates
    /// that the snapshot is stored in the standard snapshot storage tier and that
    /// it is ready
    /// for use. `archive` indicates that the snapshot is currently archived and
    /// that
    /// it must be restored before it can be used.
    storage_tier: ?StorageTier = null,

    /// Any tags assigned to the snapshot.
    tags: ?[]const Tag = null,

    /// Only for snapshot copies.
    ///
    /// Indicates whether the snapshot copy was created with a standard or
    /// time-based
    /// snapshot copy operation. Time-based snapshot copy operations complete within
    /// the
    /// completion duration specified in the request. Standard snapshot copy
    /// operations
    /// are completed on a best-effort basis.
    ///
    /// * `standard` - The snapshot copy was created with a standard
    /// snapshot copy operation.
    ///
    /// * `time-based` - The snapshot copy was created with a time-based
    /// snapshot copy operation.
    transfer_type: ?TransferType = null,

    /// The ID of the volume that was used to create the snapshot. Snapshots created
    /// by a copy
    /// snapshot operation have an arbitrary volume ID that you should not use for
    /// any purpose.
    volume_id: ?[]const u8 = null,

    /// The size of the volume, in GiB.
    volume_size: ?i32 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSnapshotInput, options: Options) !CreateSnapshotOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateSnapshot&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.location) |v| {
        try body_buf.appendSlice(alloc, "&Location=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.outpost_arn) |v| {
        try body_buf.appendSlice(alloc, "&OutpostArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&VolumeId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.volume_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateSnapshotOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "availabilityZone")) {
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "completionDurationMinutes")) {
                    result.completion_duration_minutes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "completionTime")) {
                    result.completion_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "dataEncryptionKeyId")) {
                    result.data_encryption_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "fullSnapshotSizeInBytes")) {
                    result.full_snapshot_size_in_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "kmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "outpostArn")) {
                    result.outpost_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ownerAlias")) {
                    result.owner_alias = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ownerId")) {
                    result.owner_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "progress")) {
                    result.progress = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "restoreExpiryTime")) {
                    result.restore_expiry_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "snapshotId")) {
                    result.snapshot_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "sseType")) {
                    result.sse_type = std.meta.stringToEnum(SSEType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "startTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "status")) {
                    result.state = std.meta.stringToEnum(SnapshotState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "statusMessage")) {
                    result.state_message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "storageTier")) {
                    result.storage_tier = std.meta.stringToEnum(StorageTier, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "tagSet")) {
                    result.tags = try serde.deserializeTagList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "transferType")) {
                    result.transfer_type = std.meta.stringToEnum(TransferType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "volumeId")) {
                    result.volume_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "volumeSize")) {
                    result.volume_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
