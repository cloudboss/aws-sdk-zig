const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NetworkInterfaceAttribute = @import("network_interface_attribute.zig").NetworkInterfaceAttribute;
const NetworkInterfaceAttachment = @import("network_interface_attachment.zig").NetworkInterfaceAttachment;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const GroupIdentifier = @import("group_identifier.zig").GroupIdentifier;
const AttributeBooleanValue = @import("attribute_boolean_value.zig").AttributeBooleanValue;
const serde = @import("serde.zig");

pub const DescribeNetworkInterfaceAttributeInput = struct {
    /// The attribute of the network interface. This parameter is required.
    attribute: ?NetworkInterfaceAttribute = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the network interface.
    network_interface_id: []const u8,
};

pub const DescribeNetworkInterfaceAttributeOutput = struct {
    /// Indicates whether to assign a public IPv4 address to a network interface.
    /// This option
    /// can be enabled for any network interface but will only apply to the primary
    /// network
    /// interface (eth0).
    associate_public_ip_address: ?bool = null,

    /// The attachment (if any) of the network interface.
    attachment: ?NetworkInterfaceAttachment = null,

    /// The description of the network interface.
    description: ?AttributeValue = null,

    /// The security groups associated with the network interface.
    groups: ?[]const GroupIdentifier = null,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    /// Indicates whether source/destination checking is enabled.
    source_dest_check: ?AttributeBooleanValue = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeNetworkInterfaceAttributeOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeNetworkInterfaceAttributeInput, options: Options) !DescribeNetworkInterfaceAttributeOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeNetworkInterfaceAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeNetworkInterfaceAttribute&Version=2016-11-15");
    if (input.attribute) |v| {
        try body_buf.appendSlice(alloc, "&Attribute=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&NetworkInterfaceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.network_interface_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeNetworkInterfaceAttributeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeNetworkInterfaceAttributeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "associatePublicIpAddress")) {
                    result.associate_public_ip_address = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "attachment")) {
                    result.attachment = try serde.deserializeNetworkInterfaceAttachment(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "description")) {
                    result.description = try serde.deserializeAttributeValue(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "groupSet")) {
                    result.groups = try serde.deserializeGroupIdentifierList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "networkInterfaceId")) {
                    result.network_interface_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "sourceDestCheck")) {
                    result.source_dest_check = try serde.deserializeAttributeBooleanValue(&reader, alloc);
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
