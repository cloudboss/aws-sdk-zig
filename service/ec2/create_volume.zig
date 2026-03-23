const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
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

pub const CreateVolumeOutput = @import("volume.zig").Volume;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVolumeInput, options: CallOptions) !CreateVolumeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVolumeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateVolume&Version=2016-11-15");
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.availability_zone_id) |v| {
        try body_buf.appendSlice(allocator, "&AvailabilityZoneId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.encrypted) |v| {
        try body_buf.appendSlice(allocator, "&Encrypted=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.iops) |v| {
        try body_buf.appendSlice(allocator, "&Iops=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.multi_attach_enabled) |v| {
        try body_buf.appendSlice(allocator, "&MultiAttachEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.operator) |v| {
        if (v.principal) |sv| {
            try body_buf.appendSlice(allocator, "&Operator.Principal=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.outpost_arn) |v| {
        try body_buf.appendSlice(allocator, "&OutpostArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.size) |v| {
        try body_buf.appendSlice(allocator, "&Size=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.snapshot_id) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.key) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.throughput) |v| {
        try body_buf.appendSlice(allocator, "&Throughput=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.volume_initialization_rate) |v| {
        try body_buf.appendSlice(allocator, "&VolumeInitializationRate=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.volume_type) |v| {
        try body_buf.appendSlice(allocator, "&VolumeType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVolumeOutput {
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
                    result.attachments = try serde.deserializeVolumeAttachmentList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "availabilityZone")) {
                    result.availability_zone = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "availabilityZoneId")) {
                    result.availability_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "createTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "fastRestored")) {
                    result.fast_restored = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "iops")) {
                    result.iops = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "kmsKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "multiAttachEnabled")) {
                    result.multi_attach_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "operator")) {
                    result.operator = try serde.deserializeOperatorResponse(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "outpostArn")) {
                    result.outpost_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "size")) {
                    result.size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "snapshotId")) {
                    result.snapshot_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "sourceVolumeId")) {
                    result.source_volume_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "sseType")) {
                    result.sse_type = SSEType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "status")) {
                    result.state = VolumeState.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "tagSet")) {
                    result.tags = try serde.deserializeTagList(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "throughput")) {
                    result.throughput = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "volumeId")) {
                    result.volume_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "volumeInitializationRate")) {
                    result.volume_initialization_rate = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "volumeType")) {
                    result.volume_type = VolumeType.fromWireName(try reader.readElementText());
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
