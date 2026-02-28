const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SnapshotAttributeName = @import("snapshot_attribute_name.zig").SnapshotAttributeName;
const CreateVolumePermissionModifications = @import("create_volume_permission_modifications.zig").CreateVolumePermissionModifications;
const OperationType = @import("operation_type.zig").OperationType;
const serde = @import("serde.zig");

pub const ModifySnapshotAttributeInput = struct {
    /// The snapshot attribute to modify. Only volume creation permissions can be
    /// modified.
    attribute: ?SnapshotAttributeName = null,

    /// A JSON representation of the snapshot attribute modification.
    create_volume_permission: ?CreateVolumePermissionModifications = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The group to modify for the snapshot.
    group_names: ?[]const []const u8 = null,

    /// The type of operation to perform to the attribute.
    operation_type: ?OperationType = null,

    /// The ID of the snapshot.
    snapshot_id: []const u8,

    /// The account ID to modify for the snapshot.
    user_ids: ?[]const []const u8 = null,
};

const ModifySnapshotAttributeOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifySnapshotAttributeInput, options: Options) !ModifySnapshotAttributeOutput {
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

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifySnapshotAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifySnapshotAttribute&Version=2016-11-15");
    if (input.attribute) |v| {
        try body_buf.appendSlice(alloc, "&Attribute=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.create_volume_permission) |v| {
        if (v.add) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CreateVolumePermission.Add.item.{d}.Group=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.group) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CreateVolumePermission.Add.item.{d}.UserId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.user_id) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
            }
        }
        if (v.remove) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CreateVolumePermission.Remove.item.{d}.Group=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.group) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CreateVolumePermission.Remove.item.{d}.UserId=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.user_id) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                    }
                }
            }
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.group_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserGroup.GroupName.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.operation_type) |v| {
        try body_buf.appendSlice(alloc, "&OperationType=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    try body_buf.appendSlice(alloc, "&SnapshotId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.snapshot_id);
    if (input.user_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&UserId.UserId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifySnapshotAttributeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: ModifySnapshotAttributeOutput = .{};

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
