const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const ReplaceRootVolumeTask = @import("replace_root_volume_task.zig").ReplaceRootVolumeTask;
const serde = @import("serde.zig");

pub const CreateReplaceRootVolumeTaskInput = struct {
    /// Unique, case-sensitive identifier you provide to ensure the idempotency of
    /// the request.
    /// If you do not specify a client token, a randomly generated token is used for
    /// the request
    /// to ensure idempotency. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// Indicates whether to automatically delete the original root volume after the
    /// root volume
    /// replacement task completes. To delete the original root volume, specify
    /// `true`.
    /// If you choose to keep the original root volume after the replacement task
    /// completes, you must
    /// manually delete it when you no longer need it.
    delete_replaced_root_volume: ?bool = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the AMI to use to restore the root volume. The specified AMI must
    /// have the
    /// same product code, billing information, architecture type, and
    /// virtualization type as
    /// that of the instance.
    ///
    /// If you want to restore the replacement volume from a specific snapshot, or
    /// if you want
    /// to restore it to its launch state, omit this parameter.
    image_id: ?[]const u8 = null,

    /// The ID of the instance for which to replace the root volume.
    instance_id: []const u8,

    /// The ID of the snapshot from which to restore the replacement root volume.
    /// The
    /// specified snapshot must be a snapshot that you previously created from the
    /// original
    /// root volume.
    ///
    /// If you want to restore the replacement root volume to the initial launch
    /// state,
    /// or if you want to restore the replacement root volume from an AMI, omit this
    /// parameter.
    snapshot_id: ?[]const u8 = null,

    /// The tags to apply to the root volume replacement task.
    tag_specifications: ?[]const TagSpecification = null,

    /// Specifies the Amazon EBS Provisioned Rate for Volume Initialization (volume
    /// initialization rate), in MiB/s, at which to download
    /// the snapshot blocks from Amazon S3 to the replacement root volume. This is
    /// also known as
    /// *volume initialization*. Specifying a volume initialization rate ensures
    /// that
    /// the volume is initialized at a predictable and consistent rate after
    /// creation.
    ///
    /// Omit this parameter if:
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
    volume_initialization_rate: ?i64 = null,
};

pub const CreateReplaceRootVolumeTaskOutput = struct {
    /// Information about the root volume replacement task.
    replace_root_volume_task: ?ReplaceRootVolumeTask = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateReplaceRootVolumeTaskOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateReplaceRootVolumeTaskInput, options: Options) !CreateReplaceRootVolumeTaskOutput {
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateReplaceRootVolumeTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateReplaceRootVolumeTask&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.delete_replaced_root_volume) |v| {
        try body_buf.appendSlice(alloc, "&DeleteReplacedRootVolume=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.image_id) |v| {
        try body_buf.appendSlice(alloc, "&ImageId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.instance_id);
    if (input.snapshot_id) |v| {
        try body_buf.appendSlice(alloc, "&SnapshotId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.volume_initialization_rate) |v| {
        try body_buf.appendSlice(alloc, "&VolumeInitializationRate=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateReplaceRootVolumeTaskOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateReplaceRootVolumeTaskOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "replaceRootVolumeTask")) {
                    result.replace_root_volume_task = try serde.deserializeReplaceRootVolumeTask(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
