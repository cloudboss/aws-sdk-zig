const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const serde = @import("serde.zig");

pub const CopyImageInput = struct {
    /// Unique, case-sensitive identifier you provide to ensure idempotency of the
    /// request. For
    /// more information, see [Ensuring idempotency in
    /// Amazon EC2 API
    /// requests](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html) in the *Amazon EC2 API
    /// Reference*.
    client_token: ?[]const u8 = null,

    /// Specifies whether to copy your user-defined AMI tags to the new AMI.
    ///
    /// The following tags are not be copied:
    ///
    /// * System tags (prefixed with `aws:`)
    ///
    /// * For public and shared AMIs, user-defined tags that are attached by other
    ///   Amazon Web Services
    /// accounts
    ///
    /// Default: Your user-defined AMI tags are not copied.
    copy_image_tags: ?bool = null,

    /// A description for the new AMI.
    description: ?[]const u8 = null,

    /// The Local Zone for the new AMI (for example, `cn-north-1-pkx-1a`).
    ///
    /// Only one of `DestinationAvailabilityZone`,
    /// `DestinationAvailabilityZoneId`, or `DestinationOutpostArn` can be
    /// specified.
    destination_availability_zone: ?[]const u8 = null,

    /// The ID of the Local Zone for the new AMI (for example, `cnn1-pkx1-az1`).
    ///
    /// Only one of `DestinationAvailabilityZone`,
    /// `DestinationAvailabilityZoneId`, or `DestinationOutpostArn` can be
    /// specified.
    destination_availability_zone_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Outpost for the new AMI.
    ///
    /// Only specify this parameter when copying an AMI from an Amazon Web Services
    /// Region to an Outpost. The
    /// AMI must be in the Region of the destination Outpost. You can't copy an AMI
    /// from an Outpost to
    /// a Region, from one Outpost to another, or within the same Outpost.
    ///
    /// For more information, see [Copy AMIs from an Amazon Web Services Region
    /// to an
    /// Outpost](https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html#copy-amis) in the *Amazon EBS User Guide*.
    ///
    /// Only one of `DestinationAvailabilityZone`,
    /// `DestinationAvailabilityZoneId`, or `DestinationOutpostArn` can be
    /// specified.
    destination_outpost_arn: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Specifies whether to encrypt the snapshots of the copied image.
    ///
    /// You can encrypt a copy of an unencrypted snapshot, but you cannot create an
    /// unencrypted
    /// copy of an encrypted snapshot. The default KMS key for Amazon EBS is used
    /// unless you specify a
    /// non-default Key Management Service (KMS) KMS key using `KmsKeyId`. For more
    /// information, see [Use encryption with
    /// EBS-backed
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIEncryption.html) in the *Amazon EC2 User Guide*.
    encrypted: ?bool = null,

    /// The identifier of the symmetric Key Management Service (KMS) KMS key to use
    /// when creating encrypted volumes.
    /// If this parameter is not specified, your Amazon Web Services managed KMS key
    /// for Amazon EBS is used. If you
    /// specify a KMS key, you must also set the encrypted state to `true`.
    ///
    /// You can specify a KMS key using any of the following:
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
    /// you specify an identifier
    /// that is not valid, the action can appear to complete, but eventually fails.
    ///
    /// The specified KMS key must exist in the destination Region.
    ///
    /// Amazon EBS does not support asymmetric KMS keys.
    kms_key_id: ?[]const u8 = null,

    /// The name of the new AMI.
    name: []const u8,

    /// Specify a completion duration, in 15 minute increments, to initiate a
    /// time-based AMI copy.
    /// The specified completion duration applies to each of the snapshots
    /// associated with the AMI.
    /// Each snapshot associated with the AMI will be completed within the specified
    /// completion
    /// duration, with copy throughput automatically adjusted for each snapshot
    /// based on its size to
    /// meet the timing target.
    ///
    /// If you do not specify a value, the AMI copy operation is completed on a
    /// best-effort
    /// basis.
    ///
    /// This parameter is not supported when copying an AMI to or from a Local Zone,
    /// or to an
    /// Outpost.
    ///
    /// For more information, see [Time-based copies for Amazon EBS snapshots and
    /// EBS-backed
    /// AMIs](https://docs.aws.amazon.com/ebs/latest/userguide/time-based-copies.html).
    snapshot_copy_completion_duration_minutes: ?i64 = null,

    /// The ID of the AMI to copy.
    source_image_id: []const u8,

    /// The name of the Region that contains the AMI to copy.
    source_region: []const u8,

    /// The tags to apply to the new AMI and new snapshots. You can tag the AMI, the
    /// snapshots, or
    /// both.
    ///
    /// * To tag the new AMI, the value for `ResourceType` must be
    /// `image`.
    ///
    /// * To tag the new snapshots, the value for `ResourceType` must be
    /// `snapshot`. The same tag is applied to all the new snapshots.
    ///
    /// If you specify other values for `ResourceType`, the request fails.
    ///
    /// To tag an AMI or snapshot after it has been created, see
    /// [CreateTags](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html).
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CopyImageOutput = struct {
    /// The ID of the new AMI.
    image_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyImageInput, options: CallOptions) !CopyImageOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CopyImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CopyImage&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.copy_image_tags) |v| {
        try body_buf.appendSlice(allocator, "&CopyImageTags=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.destination_availability_zone) |v| {
        try body_buf.appendSlice(allocator, "&DestinationAvailabilityZone=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.destination_availability_zone_id) |v| {
        try body_buf.appendSlice(allocator, "&DestinationAvailabilityZoneId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.destination_outpost_arn) |v| {
        try body_buf.appendSlice(allocator, "&DestinationOutpostArn=");
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
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&Name=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.name);
    if (input.snapshot_copy_completion_duration_minutes) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotCopyCompletionDurationMinutes=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&SourceImageId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_image_id);
    try body_buf.appendSlice(allocator, "&SourceRegion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_region);
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyImageOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CopyImageOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "imageId")) {
                    result.image_id = try allocator.dupe(u8, try reader.readElementText());
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
