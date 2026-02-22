const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CopyTagsFromSource = @import("copy_tags_from_source.zig").CopyTagsFromSource;
const InstanceSpecification = @import("instance_specification.zig").InstanceSpecification;
const SnapshotLocationEnum = @import("snapshot_location_enum.zig").SnapshotLocationEnum;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const SnapshotInfo = @import("snapshot_info.zig").SnapshotInfo;
const serde = @import("serde.zig");

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateSnapshotsOutput) void {
        self._arena.deinit();
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateSnapshots&Version=2016-11-15");
    if (input.copy_tags_from_source) |v| {
        try body_buf.appendSlice(alloc, "&CopyTagsFromSource=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_specification.exclude_boot_volume) |sv| {
        try body_buf.appendSlice(alloc, "&InstanceSpecification.ExcludeBootVolume=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
    }
    if (input.instance_specification.exclude_data_volume_ids) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceSpecification.ExcludeDataVolumeIds.VolumeId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    try body_buf.appendSlice(alloc, "&InstanceSpecification.InstanceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.instance_specification.instance_id);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateSnapshotsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateSnapshotsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "snapshotSet")) {
                    result.snapshots = try serde.deserializeSnapshotSet(&reader, alloc, "item");
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
