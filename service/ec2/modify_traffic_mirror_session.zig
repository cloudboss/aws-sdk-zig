const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyTrafficMirrorSessionOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyTrafficMirrorSessionInput, options: Options) !ModifyTrafficMirrorSessionOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyTrafficMirrorSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyTrafficMirrorSession&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.packet_length) |v| {
        try body_buf.appendSlice(alloc, "&PacketLength=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.remove_fields) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveField.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.session_number) |v| {
        try body_buf.appendSlice(alloc, "&SessionNumber=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.traffic_mirror_filter_id) |v| {
        try body_buf.appendSlice(alloc, "&TrafficMirrorFilterId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&TrafficMirrorSessionId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.traffic_mirror_session_id);
    if (input.traffic_mirror_target_id) |v| {
        try body_buf.appendSlice(alloc, "&TrafficMirrorTargetId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.virtual_network_id) |v| {
        try body_buf.appendSlice(alloc, "&VirtualNetworkId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyTrafficMirrorSessionOutput {
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
                    result.traffic_mirror_session = try serde.deserializeTrafficMirrorSession(&reader, alloc);
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
