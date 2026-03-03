const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EnaSrdSpecification = @import("ena_srd_specification.zig").EnaSrdSpecification;
const serde = @import("serde.zig");

pub const AttachNetworkInterfaceInput = struct {
    /// The index of the device for the network interface attachment.
    device_index: i32,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The number of ENA queues to be created with the instance.
    ena_queue_count: ?i32 = null,

    /// Configures ENA Express for the network interface that this action attaches
    /// to the
    /// instance.
    ena_srd_specification: ?EnaSrdSpecification = null,

    /// The ID of the instance.
    instance_id: []const u8,

    /// The index of the network card. Some instance types support multiple network
    /// cards. The
    /// primary network interface must be assigned to network card index 0. The
    /// default is
    /// network card index 0.
    network_card_index: ?i32 = null,

    /// The ID of the network interface.
    network_interface_id: []const u8,
};

pub const AttachNetworkInterfaceOutput = struct {
    /// The ID of the network interface attachment.
    attachment_id: ?[]const u8 = null,

    /// The index of the network card.
    network_card_index: ?i32 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AttachNetworkInterfaceInput, options: CallOptions) !AttachNetworkInterfaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AttachNetworkInterfaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=AttachNetworkInterface&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&DeviceIndex=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.device_index}) catch "");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.ena_queue_count) |v| {
        try body_buf.appendSlice(allocator, "&EnaQueueCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ena_srd_specification) |v| {
        if (v.ena_srd_enabled) |sv| {
            try body_buf.appendSlice(allocator, "&EnaSrdSpecification.EnaSrdEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.ena_srd_udp_specification) |sv| {
            if (sv.ena_srd_udp_enabled) |sv2| {
                try body_buf.appendSlice(allocator, "&EnaSrdSpecification.EnaSrdUdpSpecification.EnaSrdUdpEnabled=");
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
            }
        }
    }
    try body_buf.appendSlice(allocator, "&InstanceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.instance_id);
    if (input.network_card_index) |v| {
        try body_buf.appendSlice(allocator, "&NetworkCardIndex=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&NetworkInterfaceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.network_interface_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AttachNetworkInterfaceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: AttachNetworkInterfaceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "attachmentId")) {
                    result.attachment_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "networkCardIndex")) {
                    result.network_card_index = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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
