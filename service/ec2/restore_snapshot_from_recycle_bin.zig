const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SSEType = @import("sse_type.zig").SSEType;
const SnapshotState = @import("snapshot_state.zig").SnapshotState;

pub const RestoreSnapshotFromRecycleBinInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the snapshot to restore.
    snapshot_id: []const u8,
};

pub const RestoreSnapshotFromRecycleBinOutput = struct {
    /// The description for the snapshot.
    description: ?[]const u8 = null,

    /// Indicates whether the snapshot is encrypted.
    encrypted: ?bool = null,

    /// The ARN of the Outpost on which the snapshot is stored. For more
    /// information, see [Amazon EBS local snapshots on
    /// Outposts](https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html) in the
    /// *Amazon EBS User Guide*.
    outpost_arn: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the EBS snapshot.
    owner_id: ?[]const u8 = null,

    /// The progress of the snapshot, as a percentage.
    progress: ?[]const u8 = null,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8 = null,

    /// Reserved for future use.
    sse_type: ?SSEType = null,

    /// The time stamp when the snapshot was initiated.
    start_time: ?i64 = null,

    /// The state of the snapshot.
    state: ?SnapshotState = null,

    /// The ID of the volume that was used to create the snapshot.
    volume_id: ?[]const u8 = null,

    /// The size of the volume, in GiB.
    volume_size: ?i32 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreSnapshotFromRecycleBinInput, options: Options) !RestoreSnapshotFromRecycleBinOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreSnapshotFromRecycleBinInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=RestoreSnapshotFromRecycleBin&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&SnapshotId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.snapshot_id);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreSnapshotFromRecycleBinOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: RestoreSnapshotFromRecycleBinOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "encrypted")) {
                    result.encrypted = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "outpostArn")) {
                    result.outpost_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ownerId")) {
                    result.owner_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "progress")) {
                    result.progress = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "snapshotId")) {
                    result.snapshot_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "sseType")) {
                    result.sse_type = std.meta.stringToEnum(SSEType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "startTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "status")) {
                    result.state = std.meta.stringToEnum(SnapshotState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "volumeId")) {
                    result.volume_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "volumeSize")) {
                    result.volume_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
