const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EnableFastSnapshotRestoreSuccessItem = @import("enable_fast_snapshot_restore_success_item.zig").EnableFastSnapshotRestoreSuccessItem;
const EnableFastSnapshotRestoreErrorItem = @import("enable_fast_snapshot_restore_error_item.zig").EnableFastSnapshotRestoreErrorItem;
const serde = @import("serde.zig");

/// Enables fast snapshot restores for the specified snapshots in the specified
/// Availability Zones.
///
/// You get the full benefit of fast snapshot restores after they enter the
/// `enabled` state.
///
/// For more information, see [Amazon EBS fast snapshot
/// restore](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-fast-snapshot-restore.html) in the *Amazon EBS User Guide*.
pub const EnableFastSnapshotRestoresInput = struct {
    /// One or more Availability Zone IDs. For example, `use2-az1`.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` must be specified in the
    /// request, but not both.
    availability_zone_ids: ?[]const []const u8 = null,

    /// One or more Availability Zones. For example, `us-east-2a`.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` must be specified in the
    /// request, but not both.
    availability_zones: ?[]const []const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IDs of one or more snapshots. For example, `snap-1234567890abcdef0`. You
    /// can specify
    /// a snapshot that was shared with you from another Amazon Web Services
    /// account.
    source_snapshot_ids: []const []const u8,
};

pub const EnableFastSnapshotRestoresOutput = struct {
    /// Information about the snapshots for which fast snapshot restores were
    /// successfully enabled.
    successful: ?[]const EnableFastSnapshotRestoreSuccessItem = null,

    /// Information about the snapshots for which fast snapshot restores could not
    /// be enabled.
    unsuccessful: ?[]const EnableFastSnapshotRestoreErrorItem = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *EnableFastSnapshotRestoresOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: EnableFastSnapshotRestoresInput, options: Options) !EnableFastSnapshotRestoresOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: EnableFastSnapshotRestoresInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=EnableFastSnapshotRestores&Version=2016-11-15");
    if (input.availability_zone_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZoneIds.AvailabilityZoneId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.availability_zones) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZones.AvailabilityZone.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    for (input.source_snapshot_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SourceSnapshotIds.SnapshotId.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !EnableFastSnapshotRestoresOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: EnableFastSnapshotRestoresOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "successful")) {
                    result.successful = try serde.deserializeEnableFastSnapshotRestoreSuccessSet(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "unsuccessful")) {
                    result.unsuccessful = try serde.deserializeEnableFastSnapshotRestoreErrorSet(&reader, alloc, "item");
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
