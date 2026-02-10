const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CopyTagsFromSource = @import("copy_tags_from_source.zig").CopyTagsFromSource;
const InstanceSpecification = @import("instance_specification.zig").InstanceSpecification;
const SnapshotLocationEnum = @import("snapshot_location_enum.zig").SnapshotLocationEnum;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const SnapshotInfo = @import("snapshot_info.zig").SnapshotInfo;

/// Creates crash-consistent snapshots of multiple EBS volumes attached to an
/// Amazon EC2 instance.
/// Volumes are chosen by specifying an instance. Each volume attached to the
/// specified instance
/// will produce one snapshot that is crash-consistent across the instance. You
/// can include all of
/// the volumes currently attached to the instance, or you can exclude the root
/// volume or specific
/// data (non-root) volumes from the multi-volume snapshot set.
///
/// The location of the source instance determines where you can create the
/// snapshots.
///
/// * If the source instance is in a Region, you must create the snapshots in
///   the same
/// Region as the instance.
///
/// * If the source instance is in a Local Zone, you can create the snapshots in
///   the same
/// Local Zone or in its parent Amazon Web Services Region.
///
/// * If the source instance is on an Outpost, you can create the snapshots on
///   the same
/// Outpost or in its parent Amazon Web Services Region.
pub const CreateSnapshotsInput = struct {
    /// Copies the tags from the specified volume to corresponding snapshot.
    copy_tags_from_source: ?CopyTagsFromSource = null,

    /// A description propagated to every snapshot specified by the instance.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The instance to specify which volumes should be included in the snapshots.
    instance_specification: InstanceSpecification,

    /// **Note:**
    ///
    /// Only supported for instances in Local Zones. If the source instance is not
    /// in a Local Zone,
    /// omit this parameter.
    ///
    /// * To create local snapshots in the same Local Zone as the source instance,
    ///   specify
    /// `local`.
    ///
    /// * To create regional snapshots in the parent Region of the Local Zone,
    ///   specify
    /// `regional` or omit this parameter.
    ///
    /// Default value: `regional`
    location: ?SnapshotLocationEnum = null,

    /// **Note:**
    ///
    /// Only supported for instances on Outposts. If the source instance is not on
    /// an Outpost,
    /// omit this parameter.
    ///
    /// * To create the snapshots on the same Outpost as the source instance,
    ///   specify the
    /// ARN of that Outpost. The snapshots must be created on the same Outpost as
    /// the instance.
    ///
    /// * To create the snapshots in the parent Region of the Outpost, omit this
    ///   parameter.
    ///
    /// For more information, see [
    /// Create local snapshots from volumes on an
    /// Outpost](https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html#create-snapshot) in the *Amazon EBS User Guide*.
    outpost_arn: ?[]const u8 = null,

    /// Tags to apply to every snapshot specified by the instance.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateSnapshotsOutput = struct {
    /// List of snapshots.
    snapshots: ?[]const SnapshotInfo = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateSnapshotsOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateSnapshotsInput, options: Options) !CreateSnapshotsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateSnapshots&Version=2016-11-15");
    if (input.copy_tags_from_source) |v| {
        try body_buf.appendSlice(alloc, "&CopyTagsFromSource=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_specification.exclude_boot_volume) |sv| {
        try body_buf.appendSlice(alloc, "&InstanceSpecification.ExcludeBootVolume=");
        try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceSpecification.InstanceId=");
    try appendUrlEncoded(alloc, &body_buf, input.instance_specification.instance_id);
    if (input.location) |v| {
        try body_buf.appendSlice(alloc, "&Location=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.outpost_arn) |v| {
        try body_buf.appendSlice(alloc, "&OutpostArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateSnapshotsOutput {
    _ = status;
    _ = body;
    const result: CreateSnapshotsOutput = .{ .allocator = alloc };

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
