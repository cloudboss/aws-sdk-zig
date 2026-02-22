const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VolumeType = @import("volume_type.zig").VolumeType;
const VolumeModification = @import("volume_modification.zig").VolumeModification;
const serde = @import("serde.zig");

pub const ModifyVolumeInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The target IOPS rate of the volume. This parameter is valid only for `gp3`,
    /// `io1`, and `io2` volumes.
    ///
    /// The following are the supported values for each volume type:
    ///
    /// * `gp3`: 3,000 - 80,000 IOPS
    ///
    /// * `io1`: 100 - 64,000 IOPS
    ///
    /// * `io2`: 100 - 256,000 IOPS
    ///
    /// [
    /// Instances built on the Nitro
    /// System](https://docs.aws.amazon.com/ec2/latest/instancetypes/ec2-nitro-instances.html) can support up to 256,000 IOPS. Other instances can support up to 32,000
    /// IOPS.
    ///
    /// Default: The existing value is retained if you keep the same volume type. If
    /// you change
    /// the volume type to `io1`, `io2`, or `gp3`, the default is 3,000.
    iops: ?i32 = null,

    /// Specifies whether to enable Amazon EBS Multi-Attach. If you enable
    /// Multi-Attach, you can attach the
    /// volume to up to 16 [
    /// Nitro-based
    /// instances](https://docs.aws.amazon.com/ec2/latest/instancetypes/ec2-nitro-instances.html) in the same Availability Zone. This parameter is
    /// supported with `io1` and `io2` volumes only. For more information, see
    /// [
    /// Amazon EBS
    /// Multi-Attach](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volumes-multi.html) in the *Amazon EBS User Guide*.
    multi_attach_enabled: ?bool = null,

    /// The target size of the volume, in GiB. The target volume size must be
    /// greater than or
    /// equal to the existing size of the volume.
    ///
    /// The following are the supported volumes sizes for each volume type:
    ///
    /// * `gp2`: 1 - 16,384 GiB
    ///
    /// * `gp3`: 1 - 65,536 GiB
    ///
    /// * `io1`: 4 - 16,384 GiB
    ///
    /// * `io2`: 4 - 65,536 GiB
    ///
    /// * `st1` and `sc1`: 125 - 16,384 GiB
    ///
    /// * `standard`: 1 - 1024 GiB
    ///
    /// Default: The existing size is retained.
    size: ?i32 = null,

    /// The target throughput of the volume, in MiB/s. This parameter is valid only
    /// for `gp3` volumes.
    /// The maximum value is 2,000.
    ///
    /// Default: The existing value is retained if the source and target volume type
    /// is `gp3`.
    /// Otherwise, the default value is 125.
    ///
    /// Valid Range: Minimum value of 125. Maximum value of 2,000.
    throughput: ?i32 = null,

    /// The ID of the volume.
    volume_id: []const u8,

    /// The target EBS volume type of the volume. For more information, see [Amazon
    /// EBS volume
    /// types](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volume-types.html) in the *Amazon EBS User Guide*.
    ///
    /// Default: The existing type is retained.
    volume_type: ?VolumeType = null,
};

pub const ModifyVolumeOutput = struct {
    /// Information about the volume modification.
    volume_modification: ?VolumeModification = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyVolumeOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyVolumeInput, options: Options) !ModifyVolumeOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVolumeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVolume&Version=2016-11-15");
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
    if (input.throughput) |v| {
        try body_buf.appendSlice(alloc, "&Throughput=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(alloc, "&VolumeId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.volume_id);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyVolumeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVolumeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "volumeModification")) {
                    result.volume_modification = try serde.deserializeVolumeModification(&reader, alloc);
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
