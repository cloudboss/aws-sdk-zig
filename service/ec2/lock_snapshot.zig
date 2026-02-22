const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LockMode = @import("lock_mode.zig").LockMode;
const LockState = @import("lock_state.zig").LockState;

pub const LockSnapshotInput = struct {
    /// The cooling-off period during which you can unlock the snapshot or modify
    /// the lock settings after
    /// locking the snapshot in compliance mode, in hours. After the cooling-off
    /// period expires, you can't
    /// unlock or delete the snapshot, decrease the lock duration, or change the
    /// lock mode. You can increase
    /// the lock duration after the cooling-off period expires.
    ///
    /// The cooling-off period is optional when locking a snapshot in compliance
    /// mode. If you are locking
    /// the snapshot in governance mode, omit this parameter.
    ///
    /// To lock the snapshot in compliance mode immediately without a cooling-off
    /// period, omit this
    /// parameter.
    ///
    /// If you are extending the lock duration for a snapshot that is locked in
    /// compliance mode after
    /// the cooling-off period has expired, omit this parameter. If you specify a
    /// cooling-period in a such
    /// a request, the request fails.
    ///
    /// Allowed values: Min 1, max 72.
    cool_off_period: ?i32 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The date and time at which the snapshot lock is to automatically expire, in
    /// the UTC time zone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    ///
    /// You must specify either this parameter or **LockDuration**, but
    /// not both.
    expiration_date: ?i64 = null,

    /// The period of time for which to lock the snapshot, in days. The snapshot
    /// lock will automatically
    /// expire after this period lapses.
    ///
    /// You must specify either this parameter or **ExpirationDate**, but
    /// not both.
    ///
    /// Allowed values: Min: 1, max 36500
    lock_duration: ?i32 = null,

    /// The mode in which to lock the snapshot. Specify one of the following:
    ///
    /// * `governance` - Locks the snapshot in governance mode. Snapshots locked in
    ///   governance
    /// mode can't be deleted until one of the following conditions are met:
    ///
    /// * The lock duration expires.
    ///
    /// * The snapshot is unlocked by a user with the appropriate permissions.
    ///
    /// Users with the appropriate IAM permissions can unlock the snapshot, increase
    /// or decrease the lock
    /// duration, and change the lock mode to `compliance` at any time.
    ///
    /// If you lock a snapshot in `governance` mode, omit **
    /// CoolOffPeriod**.
    ///
    /// * `compliance` - Locks the snapshot in compliance mode. Snapshots locked in
    ///   compliance
    /// mode can't be unlocked by any user. They can be deleted only after the lock
    /// duration expires. Users
    /// can't decrease the lock duration or change the lock mode to `governance`.
    /// However, users
    /// with appropriate IAM permissions can increase the lock duration at any time.
    ///
    /// If you lock a snapshot in `compliance` mode, you can optionally specify
    /// **CoolOffPeriod**.
    lock_mode: LockMode,

    /// The ID of the snapshot to lock.
    snapshot_id: []const u8,
};

pub const LockSnapshotOutput = struct {
    /// The compliance mode cooling-off period, in hours.
    cool_off_period: ?i32 = null,

    /// The date and time at which the compliance mode cooling-off period expires,
    /// in the UTC time zone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    cool_off_period_expires_on: ?i64 = null,

    /// The date and time at which the snapshot was locked, in the UTC time zone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    lock_created_on: ?i64 = null,

    /// The period of time for which the snapshot is locked, in days.
    lock_duration: ?i32 = null,

    /// The date and time at which the lock duration started, in the UTC time zone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    lock_duration_start_time: ?i64 = null,

    /// The date and time at which the lock will expire, in the UTC time zone
    /// (`YYYY-MM-DDThh:mm:ss.sssZ`).
    lock_expires_on: ?i64 = null,

    /// The state of the snapshot lock. Valid states include:
    ///
    /// * `compliance-cooloff` - The snapshot has been locked in
    /// compliance mode but it is still within the cooling-off period. The snapshot
    /// can't be
    /// deleted, but it can be unlocked and the lock settings can be modified by
    /// users with
    /// appropriate permissions.
    ///
    /// * `governance` - The snapshot is locked in governance mode. The
    /// snapshot can't be deleted, but it can be unlocked and the lock settings can
    /// be
    /// modified by users with appropriate permissions.
    ///
    /// * `compliance` - The snapshot is locked in compliance mode and the
    /// cooling-off period has expired. The snapshot can't be unlocked or deleted.
    /// The lock
    /// duration can only be increased by users with appropriate permissions.
    ///
    /// * `expired` - The snapshot was locked in compliance or governance
    /// mode but the lock duration has expired. The snapshot is not locked and can
    /// be deleted.
    lock_state: ?LockState = null,

    /// The ID of the snapshot
    snapshot_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *LockSnapshotOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: LockSnapshotInput, options: Options) !LockSnapshotOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: LockSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=LockSnapshot&Version=2016-11-15");
    if (input.cool_off_period) |v| {
        try body_buf.appendSlice(alloc, "&CoolOffPeriod=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.expiration_date) |v| {
        try body_buf.appendSlice(alloc, "&ExpirationDate=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.lock_duration) |v| {
        try body_buf.appendSlice(alloc, "&LockDuration=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(alloc, "&LockMode=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.lock_mode));
    try body_buf.appendSlice(alloc, "&SnapshotId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.snapshot_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !LockSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: LockSnapshotOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "coolOffPeriod")) {
                    result.cool_off_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "coolOffPeriodExpiresOn")) {
                    result.cool_off_period_expires_on = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "lockCreatedOn")) {
                    result.lock_created_on = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "lockDuration")) {
                    result.lock_duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "lockDurationStartTime")) {
                    result.lock_duration_start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "lockExpiresOn")) {
                    result.lock_expires_on = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "lockState")) {
                    result.lock_state = std.meta.stringToEnum(LockState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "snapshotId")) {
                    result.snapshot_id = try alloc.dupe(u8, try reader.readElementText());
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
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
