const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const TrafficMirrorSessionField = @import("traffic_mirror_session_field.zig").TrafficMirrorSessionField;
const TrafficMirrorSession = @import("traffic_mirror_session.zig").TrafficMirrorSession;
const serde = @import("serde.zig");

pub const ModifyTrafficMirrorSessionInput = struct {
    /// The description to assign to the Traffic Mirror session.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The number of bytes in each packet to mirror. These are bytes after the
    /// VXLAN header. To mirror a subset, set this to the length (in bytes) to
    /// mirror. For example, if you set this value to 100, then the first 100 bytes
    /// that meet the filter criteria are copied to the target. Do not specify this
    /// parameter when you want to mirror the entire packet.
    ///
    /// For sessions with Network Load Balancer (NLB) traffic mirror targets, the
    /// default `PacketLength` will be set to 8500. Valid values are 1-8500. Setting
    /// a `PacketLength` greater than 8500 will result in an error response.
    packet_length: ?i32 = null,

    /// The properties that you want to remove from the Traffic Mirror session.
    ///
    /// When you remove a property from a Traffic Mirror session, the property is
    /// set to the default.
    remove_fields: ?[]const TrafficMirrorSessionField = null,

    /// The session number determines the order in which sessions are evaluated when
    /// an interface is used by multiple sessions. The first session with a matching
    /// filter is the one that mirrors the packets.
    ///
    /// Valid values are 1-32766.
    session_number: ?i32 = null,

    /// The ID of the Traffic Mirror filter.
    traffic_mirror_filter_id: ?[]const u8 = null,

    /// The ID of the Traffic Mirror session.
    traffic_mirror_session_id: []const u8,

    /// The Traffic Mirror target. The target must be in the same VPC as the source,
    /// or have a VPC peering connection with the source.
    traffic_mirror_target_id: ?[]const u8 = null,

    /// The virtual network ID of the Traffic Mirror session.
    virtual_network_id: ?i32 = null,
};

pub const ModifyTrafficMirrorSessionOutput = struct {
    /// Information about the Traffic Mirror session.
    traffic_mirror_session: ?TrafficMirrorSession = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyTrafficMirrorSessionInput, options: CallOptions) !ModifyTrafficMirrorSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyTrafficMirrorSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyTrafficMirrorSession&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.packet_length) |v| {
        try body_buf.appendSlice(allocator, "&PacketLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.remove_fields) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveField.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.session_number) |v| {
        try body_buf.appendSlice(allocator, "&SessionNumber=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.traffic_mirror_filter_id) |v| {
        try body_buf.appendSlice(allocator, "&TrafficMirrorFilterId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&TrafficMirrorSessionId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.traffic_mirror_session_id);
    if (input.traffic_mirror_target_id) |v| {
        try body_buf.appendSlice(allocator, "&TrafficMirrorTargetId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.virtual_network_id) |v| {
        try body_buf.appendSlice(allocator, "&VirtualNetworkId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyTrafficMirrorSessionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyTrafficMirrorSessionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "trafficMirrorSession")) {
                    result.traffic_mirror_session = try serde.deserializeTrafficMirrorSession(allocator, &reader);
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
