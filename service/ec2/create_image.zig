const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BlockDeviceMapping = @import("block_device_mapping.zig").BlockDeviceMapping;
const SnapshotLocationEnum = @import("snapshot_location_enum.zig").SnapshotLocationEnum;
const TagSpecification = @import("tag_specification.zig").TagSpecification;

/// Creates an Amazon EBS-backed AMI from an Amazon EBS-backed instance that is
/// either running or
/// stopped.
///
/// If you customized your instance with instance store volumes or Amazon EBS
/// volumes in addition
/// to the root device volume, the new AMI contains block device mapping
/// information for those
/// volumes. When you launch an instance from this new AMI, the instance
/// automatically launches
/// with those additional volumes.
///
/// The location of the source instance determines where you can create the
/// snapshots of the
/// AMI:
///
/// * If the source instance is in a Region, you must create the snapshots in
///   the same
/// Region as the instance.
///
/// * If the source instance is in a Local Zone, you can create the snapshots in
///   the same
/// Local Zone or in its parent Region.
///
/// For more information, see [Create an Amazon EBS-backed
/// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/creating-an-ami-ebs.html) in
/// the *Amazon Elastic Compute Cloud User Guide*.
pub const CreateImageInput = struct {
    /// The block device mappings.
    ///
    /// When using the CreateImage action:
    ///
    /// * You can't change the volume size using the VolumeSize parameter. If you
    ///   want a
    /// different volume size, you must first change the volume size of the source
    /// instance.
    ///
    /// * You can't modify the encryption status of existing volumes or snapshots.
    ///   To create an
    /// AMI with volumes or snapshots that have a different encryption status (for
    /// example, where
    /// the source volume and snapshots are unencrypted, and you want to create an
    /// AMI with
    /// encrypted volumes or snapshots), copy the image instead.
    ///
    /// * The only option that can be changed for existing mappings or snapshots is
    /// `DeleteOnTermination`.
    block_device_mappings: ?[]const BlockDeviceMapping = null,

    /// A description for the new image.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the instance.
    instance_id: []const u8,

    /// A name for the new image.
    ///
    /// Constraints: 3-128 alphanumeric characters, parentheses (()), square
    /// brackets ([]), spaces
    /// ( ), periods (.), slashes (/), dashes (-), single quotes ('), at-signs (@),
    /// or
    /// underscores(_)
    name: []const u8,

    /// Indicates whether or not the instance should be automatically rebooted
    /// before creating the
    /// image. Specify one of the following values:
    ///
    /// * `true` - The instance is not rebooted before creating the image. This
    /// creates crash-consistent snapshots that include only the data that has been
    /// written to the
    /// volumes at the time the snapshots are created. Buffered data and data in
    /// memory that has
    /// not yet been written to the volumes is not included in the snapshots.
    ///
    /// * `false` - The instance is rebooted before creating the image. This ensures
    /// that all buffered data and data in memory is written to the volumes before
    /// the snapshots
    /// are created.
    ///
    /// Default: `false`
    no_reboot: ?bool = null,

    /// **Note:**
    ///
    /// Only supported for instances in Local Zones. If the source instance is not
    /// in a Local
    /// Zone, omit this parameter.
    ///
    /// The Amazon S3 location where the snapshots will be stored.
    ///
    /// * To create local snapshots in the same Local Zone as the source instance,
    ///   specify
    /// `local`.
    ///
    /// * To create regional snapshots in the parent Region of the Local Zone,
    ///   specify
    /// `regional` or omit this parameter.
    ///
    /// Default: `regional`
    snapshot_location: ?SnapshotLocationEnum = null,

    /// The tags to apply to the AMI and snapshots on creation. You can tag the AMI,
    /// the
    /// snapshots, or both.
    ///
    /// * To tag the AMI, the value for `ResourceType` must be
    /// `image`.
    ///
    /// * To tag the snapshots that are created of the root volume and of other
    ///   Amazon EBS volumes
    /// that are attached to the instance, the value for `ResourceType` must be
    /// `snapshot`. The same tag is applied to all of the snapshots that are
    /// created.
    ///
    /// If you specify other values for `ResourceType`, the request fails.
    ///
    /// To tag an AMI or snapshot after it has been created, see
    /// [CreateTags](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTags.html).
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateImageOutput = struct {
    /// The ID of the new AMI.
    image_id: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateImageOutput) void {
        if (self.image_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateImageInput, options: Options) !CreateImageOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateImage&Version=2016-11-15");
    if (input.block_device_mappings) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.BlockDeviceMapping.{d}.DeviceName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.device_name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.BlockDeviceMapping.{d}.NoDevice=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.no_device) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&BlockDeviceMappings.BlockDeviceMapping.{d}.VirtualName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.virtual_name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try appendUrlEncoded(alloc, &body_buf, input.instance_id);
    try body_buf.appendSlice(alloc, "&Name=");
    try appendUrlEncoded(alloc, &body_buf, input.name);
    if (input.no_reboot) |v| {
        try body_buf.appendSlice(alloc, "&NoReboot=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.snapshot_location) |v| {
        try body_buf.appendSlice(alloc, "&SnapshotLocation=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateImageOutput {
    _ = status;
    var result: CreateImageOutput = .{ .allocator = alloc };
    if (findElement(body, "imageId")) |content| {
        result.image_id = try alloc.dupe(u8, content);
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
