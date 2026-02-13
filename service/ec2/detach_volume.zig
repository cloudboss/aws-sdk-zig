const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VolumeAttachmentState = @import("volume_attachment_state.zig").VolumeAttachmentState;

/// Detaches an EBS volume from an instance. Make sure to unmount any file
/// systems on the
/// device within your operating system before detaching the volume. Failure to
/// do so can result
/// in the volume becoming stuck in the `busy` state while detaching. If this
/// happens,
/// detachment can be delayed indefinitely until you unmount the volume, force
/// detachment, reboot
/// the instance, or all three. If an EBS volume is the root device of an
/// instance, it can't be
/// detached while the instance is running. To detach the root volume, stop the
/// instance
/// first.
///
/// When a volume with an Amazon Web Services Marketplace product code is
/// detached from an instance, the
/// product code is no longer associated with the instance.
///
/// You can't detach or force detach volumes that are attached to Amazon Web
/// Services-managed resources.
/// Attempting to do this results in the `UnsupportedOperationException`
/// exception.
///
/// For more information, see [Detach an Amazon EBS
/// volume](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-detaching-volume.html) in the
/// *Amazon EBS User Guide*.
pub const DetachVolumeInput = struct {
    /// The device name.
    device: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Forces detachment if the previous detachment attempt did not occur cleanly
    /// (for example,
    /// logging into an instance, unmounting the volume, and detaching normally).
    /// This option can lead
    /// to data loss or a corrupted file system. Use this option only as a last
    /// resort to detach a
    /// volume from a failed instance. The instance won't have an opportunity to
    /// flush file system
    /// caches or file system metadata. If you use this option, you must perform
    /// file system check and
    /// repair procedures.
    force: ?bool = null,

    /// The ID of the instance. If you are detaching a Multi-Attach enabled volume,
    /// you must specify an instance ID.
    instance_id: ?[]const u8 = null,

    /// The ID of the volume.
    volume_id: []const u8,
};

pub const DetachVolumeOutput = struct {
    /// The ARN of the Amazon Web Services-managed resource
    /// to which the volume is attached.
    associated_resource: ?[]const u8 = null,

    /// The time stamp when the attachment initiated.
    attach_time: ?i64 = null,

    /// Indicates whether the EBS volume is deleted on instance termination.
    delete_on_termination: ?bool = null,

    /// The device name.
    ///
    /// If the volume is attached to an Amazon Web Services-managed resource, this
    /// parameter
    /// returns `null`.
    device: ?[]const u8 = null,

    /// The index of the EBS card. Some instance types support multiple EBS cards.
    /// The default EBS card index is 0.
    ebs_card_index: ?i32 = null,

    /// The ID of the instance.
    ///
    /// If the volume is attached to an Amazon Web Services-managed resource, this
    /// parameter
    /// returns `null`.
    instance_id: ?[]const u8 = null,

    /// The service principal of the Amazon Web Services service that owns the
    /// underlying
    /// resource to which the volume is attached.
    ///
    /// This parameter is returned only for volumes that are attached to
    /// Amazon Web Services-managed resources.
    instance_owning_service: ?[]const u8 = null,

    /// The attachment state of the volume.
    state: ?VolumeAttachmentState = null,

    /// The ID of the volume.
    volume_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DetachVolumeOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DetachVolumeInput, options: Options) !DetachVolumeOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DetachVolumeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DetachVolume&Version=2016-11-15");
    if (input.device) |v| {
        try body_buf.appendSlice(alloc, "&Device=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.force) |v| {
        try body_buf.appendSlice(alloc, "&Force=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_id) |v| {
        try body_buf.appendSlice(alloc, "&InstanceId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DetachVolumeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DetachVolumeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "associatedResource")) {
                    result.associated_resource = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "attachTime")) {
                    result.attach_time = aws.imds.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "deleteOnTermination")) {
                    result.delete_on_termination = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "device")) {
                    result.device = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ebsCardIndex")) {
                    result.ebs_card_index = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "instanceId")) {
                    result.instance_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "instanceOwningService")) {
                    result.instance_owning_service = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "status")) {
                    result.state = std.meta.stringToEnum(VolumeAttachmentState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "volumeId")) {
                    result.volume_id = try alloc.dupe(u8, try reader.readElementText());
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
