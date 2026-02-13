const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DeleteSnapshotReturnCode = @import("delete_snapshot_return_code.zig").DeleteSnapshotReturnCode;
const serde = @import("serde.zig");

/// Deregisters the specified AMI. A deregistered AMI can't be used to launch
/// new
/// instances.
///
/// If a deregistered EBS-backed AMI matches a Recycle Bin retention rule, it
/// moves to the
/// Recycle Bin for the specified retention period. It can be restored before
/// its retention period
/// expires, after which it is permanently deleted. If the deregistered AMI
/// doesn't match a
/// retention rule, it is permanently deleted immediately. For more information,
/// see [Recover deleted Amazon EBS
/// snapshots and EBS-backed AMIs with Recycle
/// Bin](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recycle-bin.html)
/// in the *Amazon EBS User
/// Guide*.
///
/// When deregistering an EBS-backed AMI, you can optionally delete its
/// associated snapshots
/// at the same time. However, if a snapshot is associated with multiple AMIs,
/// it won't be deleted
/// even if specified for deletion, although the AMI will still be deregistered.
///
/// Deregistering an AMI does not delete the following:
///
/// * Instances already launched from the AMI. You'll continue to incur usage
///   costs for the
/// instances until you terminate them.
///
/// * For EBS-backed AMIs: Snapshots that are associated with multiple AMIs.
///   You'll continue
/// to incur snapshot storage costs.
///
/// * For instance store-backed AMIs: The files uploaded to Amazon S3 during AMI
///   creation. You'll
/// continue to incur S3 storage costs.
///
/// For more information, see [Deregister an Amazon EC2
/// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/deregister-ami.html) in the
/// *Amazon EC2 User Guide*.
pub const DeregisterImageInput = struct {
    /// Specifies whether to delete the snapshots associated with the AMI during
    /// deregistration.
    ///
    /// **Note:**
    ///
    /// If a snapshot is associated with multiple AMIs, it is not deleted,
    /// regardless of this setting.
    ///
    /// Default: The snapshots are not deleted.
    delete_associated_snapshots: ?bool = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the AMI.
    image_id: []const u8,
};

pub const DeregisterImageOutput = struct {
    /// The deletion result for each snapshot associated with the AMI, including the
    /// snapshot ID
    /// and its success or error code.
    delete_snapshot_results: ?[]const DeleteSnapshotReturnCode = null,

    /// Returns `true` if the request succeeds; otherwise, it returns an error.
    @"return": ?bool = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DeregisterImageOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DeregisterImageInput, options: Options) !DeregisterImageOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DeregisterImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DeregisterImage&Version=2016-11-15");
    if (input.delete_associated_snapshots) |v| {
        try body_buf.appendSlice(alloc, "&DeleteAssociatedSnapshots=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&ImageId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.image_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DeregisterImageOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DeregisterImageOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "deleteSnapshotResultSet")) {
                    result.delete_snapshot_results = try serde.deserializeDeleteSnapshotResultSet(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
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
