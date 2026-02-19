const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const VolumeType = @import("volume_type.zig").VolumeType;
const Volume = @import("volume.zig").Volume;
const serde = @import("serde.zig");

pub const CopyVolumesInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the
    /// request. For more information, see [
    /// Ensure
    /// Idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The number of I/O operations per second (IOPS) to provision for the volume
    /// copy.
    /// Required for `io1` and `io2` volumes. Optional for `gp3`
    /// volumes. Omit for all other volume types. Full provisioned IOPS performance
    /// can be
    /// achieved only once the volume copy is fully initialized.
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

    /// Indicates whether to enable Amazon EBS Multi-Attach for the volume copy. If
    /// you enable
    /// Multi-Attach, you can attach the volume to up to 16 Nitro instances in the
    /// same
    /// Availability Zone simultaneously. Supported with `io1` and `io2` volumes
    /// only. For more
    /// information, see [
    /// Amazon EBS
    /// Multi-Attach](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volumes-multi.html).
    multi_attach_enabled: ?bool = null,

    /// The size of the volume copy, in GiBs. The size must be equal to or greater
    /// than the
    /// size of the source volume. If not specified, the size defaults to the size
    /// of the source
    /// volume.
    ///
    /// Maximum supported sizes:
    ///
    /// * gp2: `16,384` GiB
    ///
    /// * gp3: `65,536` GiB
    ///
    /// * io1: `16,384` GiB
    ///
    /// * io2: `65,536` GiB
    ///
    /// * st1 and sc1: `16,384` GiB
    ///
    /// * standard: `1024` GiB
    size: ?i32 = null,

    /// The ID of the source EBS volume to copy.
    source_volume_id: []const u8,

    /// The tags to apply to the volume copy during creation.
    tag_specifications: ?[]const TagSpecification = null,

    /// The throughput to provision for the volume copy, in MiB/s. Supported for
    /// `gp3`
    /// volumes only. Omit for all other volume types. Full provisioned throughput
    /// performance can be
    /// achieved only once the volume copy is fully initialized.
    ///
    /// Valid Range: `125 - 2000` MiB/s
    throughput: ?i32 = null,

    /// The volume type for the volume copy. If not specified, the volume type
    /// defaults to
    /// `gp2`.
    volume_type: ?VolumeType = null,
};

pub const CopyVolumesOutput = struct {
    /// Information about the volume copy.
    volumes: ?[]const Volume = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CopyVolumesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CopyVolumesInput, options: Options) !CopyVolumesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CopyVolumesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CopyVolumes&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.iops) |v| {
        try body_buf.appendSlice(alloc, "&Iops=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.multi_attach_enabled) |v| {
        try body_buf.appendSlice(alloc, "&MultiAttachEnabled=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.size) |v| {
        try body_buf.appendSlice(alloc, "&Size=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(alloc, "&SourceVolumeId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.source_volume_id);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CopyVolumesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CopyVolumesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "volumeSet")) {
                    result.volumes = try serde.deserializeVolumeList(&reader, alloc, "item");
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
