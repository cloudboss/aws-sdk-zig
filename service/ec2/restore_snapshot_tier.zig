const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Restores an archived Amazon EBS snapshot for use temporarily or permanently,
/// or modifies the restore
/// period or restore type for a snapshot that was previously temporarily
/// restored.
///
/// For more information see [
/// Restore an archived
/// snapshot](https://docs.aws.amazon.com/ebs/latest/userguide/working-with-snapshot-archiving.html#restore-archived-snapshot) and [
/// modify the restore period or restore type for a temporarily restored
/// snapshot](https://docs.aws.amazon.com/ebs/latest/userguide/working-with-snapshot-archiving.html#modify-temp-restore-period) in the *Amazon EBS User Guide*.
pub const RestoreSnapshotTierInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Indicates whether to permanently restore an archived snapshot. To
    /// permanently restore
    /// an archived snapshot, specify `true` and omit the
    /// **RestoreSnapshotTierRequest$TemporaryRestoreDays** parameter.
    permanent_restore: ?bool = null,

    /// The ID of the snapshot to restore.
    snapshot_id: []const u8,

    /// Specifies the number of days for which to temporarily restore an archived
    /// snapshot.
    /// Required for temporary restores only. The snapshot will be automatically
    /// re-archived
    /// after this period.
    ///
    /// To temporarily restore an archived snapshot, specify the number of days and
    /// omit
    /// the **PermanentRestore** parameter or set it to
    /// `false`.
    temporary_restore_days: ?i32 = null,
};

pub const RestoreSnapshotTierOutput = struct {
    /// Indicates whether the snapshot is permanently restored. `true` indicates a
    /// permanent
    /// restore. `false` indicates a temporary restore.
    is_permanent_restore: ?bool = null,

    /// For temporary restores only. The number of days for which the archived
    /// snapshot
    /// is temporarily restored.
    restore_duration: ?i32 = null,

    /// The date and time when the snapshot restore process started.
    restore_start_time: ?i64 = null,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const RestoreSnapshotTierOutput) void {
        if (self.snapshot_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RestoreSnapshotTierInput, options: Options) !RestoreSnapshotTierOutput {
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

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: RestoreSnapshotTierInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=RestoreSnapshotTier&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.permanent_restore) |v| {
        try body_buf.appendSlice(alloc, "&PermanentRestore=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&SnapshotId=");
    try appendUrlEncoded(alloc, &body_buf, input.snapshot_id);
    if (input.temporary_restore_days) |v| {
        try body_buf.appendSlice(alloc, "&TemporaryRestoreDays=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RestoreSnapshotTierOutput {
    _ = status;
    _ = headers;
    var result: RestoreSnapshotTierOutput = .{ .allocator = alloc };
    if (findElement(body, "isPermanentRestore")) |content| {
        result.is_permanent_restore = std.mem.eql(u8, content, "true");
    }
    if (findElement(body, "restoreDuration")) |content| {
        result.restore_duration = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findElement(body, "restoreStartTime")) |content| {
        result.restore_start_time = std.fmt.parseInt(i64, content, 10) catch null;
    }
    if (findElement(body, "snapshotId")) |content| {
        result.snapshot_id = try alloc.dupe(u8, content);
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
