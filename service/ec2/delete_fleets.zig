const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DeleteFleetSuccessItem = @import("delete_fleet_success_item.zig").DeleteFleetSuccessItem;
const DeleteFleetErrorItem = @import("delete_fleet_error_item.zig").DeleteFleetErrorItem;

/// Deletes the specified EC2 Fleet request.
///
/// After you delete an EC2 Fleet request, it launches no new instances.
///
/// You must also specify whether a deleted EC2 Fleet request should terminate
/// its instances. If
/// you choose to terminate the instances, the EC2 Fleet request enters the
/// `deleted_terminating` state. Otherwise, it enters the
/// `deleted_running` state, and the instances continue to run until they are
/// interrupted or you terminate them manually.
///
/// A deleted `instant` fleet with running instances is not supported. When you
/// delete an `instant` fleet, Amazon EC2 automatically terminates all its
/// instances. For
/// fleets with more than 1000 instances, the deletion request might fail. If
/// your fleet has
/// more than 1000 instances, first terminate most of the instances manually,
/// leaving 1000 or
/// fewer. Then delete the fleet, and the remaining instances will be terminated
/// automatically.
///
/// **Important:**
///
/// **Terminating an instance is permanent and irreversible.**
///
/// After you terminate an instance, you can no longer connect to it, and it
/// can't be recovered.
/// All attached Amazon EBS volumes that are configured to be deleted on
/// termination are also permanently
/// deleted and can't be recovered. All data stored on instance store volumes is
/// permanently lost.
/// For more information, see [
/// How instance termination
/// works](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/how-ec2-instance-termination-works.html).
///
/// Before you terminate an instance, ensure that you have backed up all data
/// that you need to
/// retain after the termination to persistent storage.
///
/// **Restrictions**
///
/// * You can delete up to 25 fleets of type `instant` in a single
/// request.
///
/// * You can delete up to 100 fleets of type `maintain` or
/// `request` in a single request.
///
/// * You can delete up to 125 fleets in a single request, provided you do not
///   exceed
/// the quota for each fleet type, as specified above.
///
/// * If you exceed the specified number of fleets to delete, no fleets are
/// deleted.
///
/// For more information, see [Delete an EC2 Fleet request and the instances
/// in the
/// fleet](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/delete-fleet.html) in the *Amazon EC2 User Guide*.
pub const DeleteFleetsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IDs of the EC2 Fleets.
    ///
    /// Constraints: In a single request, you can specify up to 25 `instant` fleet
    /// IDs and up to 100 `maintain` or `request` fleet IDs.
    fleet_ids: []const []const u8,

    /// Indicates whether to terminate the associated instances when the EC2 Fleet
    /// is deleted. The default is to
    /// terminate the instances.
    ///
    /// To let the instances continue to run after the EC2 Fleet is deleted, specify
    /// `no-terminate-instances`. Supported only for fleets of type
    /// `maintain` and `request`.
    ///
    /// For `instant` fleets, you cannot specify `NoTerminateInstances`. A
    /// deleted `instant` fleet with running instances is not supported.
    terminate_instances: bool,
};

pub const DeleteFleetsOutput = struct {
    /// Information about the EC2 Fleets that are successfully deleted.
    successful_fleet_deletions: ?[]const DeleteFleetSuccessItem = null,

    /// Information about the EC2 Fleets that are not successfully deleted.
    unsuccessful_fleet_deletions: ?[]const DeleteFleetErrorItem = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const DeleteFleetsOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DeleteFleetsInput, options: Options) !DeleteFleetsOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: DeleteFleetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DeleteFleets&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    for (input.fleet_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&FleetIds.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try appendUrlEncoded(alloc, &body_buf, item);
    }
    try body_buf.appendSlice(alloc, "&TerminateInstances=");
    try appendUrlEncoded(alloc, &body_buf, if (input.terminate_instances) "true" else "false");

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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !DeleteFleetsOutput {
    _ = status;
    _ = body;
    const result: DeleteFleetsOutput = .{ .allocator = alloc };

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
