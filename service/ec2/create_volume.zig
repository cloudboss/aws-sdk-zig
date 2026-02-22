const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const OperatorRequest = @import("operator_request.zig").OperatorRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const VolumeType = @import("volume_type.zig").VolumeType;
const VolumeAttachment = @import("volume_attachment.zig").VolumeAttachment;
const OperatorResponse = @import("operator_response.zig").OperatorResponse;
const SSEType = @import("sse_type.zig").SSEType;
const VolumeState = @import("volume_state.zig").VolumeState;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateVolumeInput = struct {
    /// The ID of the Availability Zone in which to create the volume. For example,
    /// `us-east-1a`.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` must be specified,
    /// but not both.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone in which to create the volume. For example,
    /// `use1-az1`.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` must be specified,
    /// but not both.
    availability_zone_id: ?[]const u8 = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information, see [Ensure
    /// Idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Indicates whether the volume should be encrypted.
    /// The effect of setting the encryption state to `true` depends on
    /// the volume origin (new or from a snapshot), starting encryption state,
    /// ownership, and whether encryption by default is enabled.
    /// For more information, see [Encryption by
    /// default](https://docs.aws.amazon.com/ebs/latest/userguide/work-with-ebs-encr.html#encryption-by-default)
    /// in the *Amazon EBS User Guide*.
    ///
    /// Encrypted Amazon EBS volumes must be attached to instances that support
    /// Amazon EBS encryption.
    /// For more information, see [Supported
    /// instance
    /// types](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption-requirements.html#ebs-encryption_supported_instances).
    encrypted: ?bool = null,

    /// The number of I/O operations per second (IOPS) to provision for the volume.
    /// Required for `io1` and `io2` volumes. Optional for `gp3`
    /// volumes. Omit for all other volume types.
    ///
    /// Valid ranges:
    ///
    /// * gp3: `3,000 `(*default*)` - 80,000` IOPS
    ///
    /// * io1: `100 - 64,000` IOPS
    ///
    /// * io2: `100 - 256,000` IOPS
    ///
    /// [
    /// Instances built on the Nitro
    /// System](https://docs.aws.amazon.com/ec2/latest/instancetypes/ec2-nitro-instances.html) can support up to 256,000 IOPS. Other instances can support up to 32,000
    /// IOPS.
    iops: ?i32 = null,

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

    /// Indicates whether to enable Amazon EBS Multi-Attach. If you enable
    /// Multi-Attach, you can attach the
    /// volume to up to 16 [Instances built on the Nitro
    /// System](https://docs.aws.amazon.com/ec2/latest/instancetypes/ec2-nitro-instances.html) in the same Availability Zone. This parameter is
    /// supported with `io1` and `io2` volumes only. For more information,
    /// see [
    /// Amazon EBS
    /// Multi-Attach](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volumes-multi.html) in the *Amazon EBS User Guide*.
    multi_attach_enabled: ?bool = null,

    /// Reserved for internal use.
    operator: ?OperatorRequest = null,

    /// The Amazon Resource Name (ARN) of the Outpost on which to create the volume.
    ///
    /// If you intend to use a volume with an instance running on an outpost, then
    /// you must
    /// create the volume on the same outpost as the instance. You can't use a
    /// volume created
    /// in an Amazon Web Services Region with an instance on an Amazon Web Services
    /// outpost, or the other way around.
    outpost_arn: ?[]const u8 = null,

    /// The size of the volume, in GiBs. You must specify either a snapshot ID or a
    /// volume size.
    /// If you specify a snapshot, the default is the snapshot size, and you can
    /// specify a volume size
    /// that is equal to or larger than the snapshot size.
    ///
    /// Valid sizes:
    ///
    /// * gp2: `1 - 16,384` GiB
    ///
    /// * gp3: `1 - 65,536` GiB
    ///
    /// * io1: `4 - 16,384` GiB
    ///
    /// * io2: `4 - 65,536` GiB
    ///
    /// * st1 and sc1: `125 - 16,384` GiB
    ///
    /// * standard: `1 - 1024` GiB
    size: ?i32 = null,

    /// The snapshot from which to create the volume. You must specify either a
    /// snapshot ID or a volume size.
    snapshot_id: ?[]const u8 = null,

    /// The tags to apply to the volume during creation.
    tag_specifications: ?[]const TagSpecification = null,

    /// The throughput to provision for the volume, in MiB/s. Supported for `gp3`
    /// volumes only. Omit for all other volume types.
    ///
    /// Valid Range: `125 - 2000` MiB/s
    throughput: ?i32 = null,

    /// Specifies the Amazon EBS Provisioned Rate for Volume Initialization (volume
    /// initialization rate), in MiB/s, at which to download
    /// the snapshot blocks from Amazon S3 to the volume. This is also known as
    /// *volume
    /// initialization*. Specifying a volume initialization rate ensures that the
    /// volume is
    /// initialized at a predictable and consistent rate after creation.
    ///
    /// This parameter is supported only for volumes created from snapshots. Omit
    /// this parameter
    /// if:
    ///
    /// * You want to create the volume using fast snapshot restore. You must
    ///   specify a snapshot
    /// that is enabled for fast snapshot restore. In this case, the volume is fully
    /// initialized at
    /// creation.
    ///
    /// If you specify a snapshot that is enabled for fast snapshot restore and a
    /// volume initialization rate,
    /// the volume will be initialized at the specified rate instead of fast
    /// snapshot restore.
    ///
    /// * You want to create a volume that is initialized at the default rate.
    ///
    /// For more information, see [
    /// Initialize Amazon EBS
    /// volumes](https://docs.aws.amazon.com/ebs/latest/userguide/initalize-volume.html) in the *Amazon EC2 User Guide*.
    ///
    /// Valid range: 100 - 300 MiB/s
    volume_initialization_rate: ?i32 = null,

    /// The volume type. This parameter can be one of the following values:
    ///
    /// * General Purpose SSD: `gp2` | `gp3`
    ///
    /// * Provisioned IOPS SSD: `io1` | `io2`
    ///
    /// * Throughput Optimized HDD: `st1`
    ///
    /// * Cold HDD: `sc1`
    ///
    /// * Magnetic: `standard`
    ///
    /// Throughput Optimized HDD (`st1`) and Cold HDD (`sc1`) volumes can't be used
    /// as boot volumes.
    ///
    /// For more information, see [Amazon EBS volume
    /// types](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volume-types.html) in the
    /// *Amazon EBS User Guide*.
    ///
    /// Default: `gp2`
    volume_type: ?VolumeType = null,
};

pub const CreateVolumeOutput = struct {
    /// This parameter is not returned by CreateVolume.
    ///
    /// Information about the volume attachments.
    attachments: ?[]const VolumeAttachment = null,

    /// The Availability Zone for the volume.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone for the volume.
    availability_zone_id: ?[]const u8 = null,

    /// The time stamp when volume creation was initiated.
    create_time: ?i64 = null,

    /// Indicates whether the volume is encrypted.
    encrypted: ?bool = null,

    /// This parameter is not returned by CreateVolume.
    ///
    /// Indicates whether the volume was created using fast snapshot restore.
    fast_restored: ?bool = null,

    /// The number of I/O operations per second (IOPS). For `gp3`, `io1`, and `io2`
    /// volumes, this represents
    /// the number of IOPS that are provisioned for the volume. For `gp2` volumes,
    /// this represents the baseline
    /// performance of the volume and the rate at which the volume accumulates I/O
    /// credits for bursting.
    iops: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the KMS key that was used to protect the
    /// volume encryption key for the volume.
    kms_key_id: ?[]const u8 = null,

    /// Indicates whether Amazon EBS Multi-Attach is enabled.
    multi_attach_enabled: ?bool = null,

    /// The service provider that manages the volume.
    operator: ?OperatorResponse = null,

    /// The Amazon Resource Name (ARN) of the Outpost.
    outpost_arn: ?[]const u8 = null,

    /// The size of the volume, in GiBs.
    size: ?i32 = null,

    /// The snapshot from which the volume was created, if applicable.
    snapshot_id: ?[]const u8 = null,

    /// The ID of the source volume from which the volume copy was created. Only for
    /// volume copies.
    source_volume_id: ?[]const u8 = null,

    /// This parameter is not returned by CreateVolume.
    ///
    /// Reserved for future use.
    sse_type: ?SSEType = null,

    /// The volume state.
    state: ?VolumeState = null,

    /// Any tags assigned to the volume.
    tags: ?[]const Tag = null,

    /// The throughput that the volume supports, in MiB/s.
    throughput: ?i32 = null,

    /// The ID of the volume.
    volume_id: ?[]const u8 = null,

    /// The Amazon EBS Provisioned Rate for Volume Initialization (volume
    /// initialization rate) specified for the volume during creation,
    /// in MiB/s. If no volume initialization rate was specified, the value is
    /// `null`.
    volume_initialization_rate: ?i32 = null,

    /// The volume type.
    volume_type: ?VolumeType = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateVolumeOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateVolumeInput, options: Options) !CreateVolumeOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateVolumeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateVolume&Version=2016-11-15");
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZone=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.availability_zone_id) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZoneId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.encrypted) |v| {
        try body_buf.appendSlice(alloc, "&Encrypted=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.iops) |v| {
        try body_buf.appendSlice(alloc, "&Iops=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(alloc, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.multi_attach_enabled) |v| {
        try body_buf.appendSlice(alloc, "&MultiAttachEnabled=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.operator) |v| {
        if (v.principal) |sv| {
            try body_buf.appendSlice(alloc, "&Operator.Principal=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.outpost_arn) |v| {
        try body_buf.appendSlice(alloc, "&OutpostArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.size) |v| {
        try body_buf.appendSlice(alloc, "&Size=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.snapshot_id) |v| {
        try body_buf.appendSlice(alloc, "&SnapshotId=");
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
    if (input.throughput) |v| {
        try body_buf.appendSlice(alloc, "&Throughput=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.volume_initialization_rate) |v| {
        try body_buf.appendSlice(alloc, "&VolumeInitializationRate=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.volume_type) |v| {
        try body_buf.appendSlice(alloc, "&VolumeType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateVolumeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateVolumeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "attachmentSet")) {
                    result.attachments = try serde.deserializeVolumeAttachmentList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "availabilityZone")) {
                    result.availability_zone = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "availabilityZoneId")) {
                    result.availability_zone_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "createTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "fastRestored")) {
                    result.fast_restored = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "kmsKeyId")) {
                    result.kms_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "multiAttachEnabled")) {
                    result.multi_attach_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "operator")) {
                    result.operator = try serde.deserializeOperatorResponse(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "outpostArn")) {
                    result.outpost_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "size")) {
                    result.size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "snapshotId")) {
                    result.snapshot_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "sourceVolumeId")) {
                    result.source_volume_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "sseType")) {
                    result.sse_type = std.meta.stringToEnum(SSEType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "status")) {
                    result.state = std.meta.stringToEnum(VolumeState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "tagSet")) {
                    result.tags = try serde.deserializeTagList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "throughput")) {
                    result.throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "volumeId")) {
                    result.volume_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "volumeInitializationRate")) {
                    result.volume_initialization_rate = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "volumeType")) {
                    result.volume_type = std.meta.stringToEnum(VolumeType, try reader.readElementText());
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
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, request_id);
    errdefer alloc.free(owned_request_id);


    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
