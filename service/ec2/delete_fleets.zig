const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DeleteFleetSuccessItem = @import("delete_fleet_success_item.zig").DeleteFleetSuccessItem;
const DeleteFleetErrorItem = @import("delete_fleet_error_item.zig").DeleteFleetErrorItem;
const serde = @import("serde.zig");

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFleetsInput, options: Options) !DeleteFleetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFleetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DeleteFleets&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    for (input.fleet_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&FleetId.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }
    try body_buf.appendSlice(allocator, "&TerminateInstances=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.terminate_instances) "true" else "false");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFleetsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DeleteFleetsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "successfulFleetDeletionSet")) {
                    result.successful_fleet_deletions = try serde.deserializeDeleteFleetSuccessSet(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "unsuccessfulFleetDeletionSet")) {
                    result.unsuccessful_fleet_deletions = try serde.deserializeDeleteFleetErrorSet(allocator, &reader, "item");
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
