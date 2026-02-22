const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NetworkInterfaceAttachmentChanges = @import("network_interface_attachment_changes.zig").NetworkInterfaceAttachmentChanges;
const ConnectionTrackingSpecificationRequest = @import("connection_tracking_specification_request.zig").ConnectionTrackingSpecificationRequest;
const AttributeValue = @import("attribute_value.zig").AttributeValue;
const EnaSrdSpecification = @import("ena_srd_specification.zig").EnaSrdSpecification;
const AttributeBooleanValue = @import("attribute_boolean_value.zig").AttributeBooleanValue;
const serde = @import("serde.zig");

pub const ModifyNetworkInterfaceAttributeInput = struct {
    /// A list of subnet IDs to associate with the network interface.
    associated_subnet_ids: ?[]const []const u8 = null,

    /// Indicates whether to assign a public IPv4 address to a network interface.
    /// This option
    /// can be enabled for any network interface but will only apply to the primary
    /// network
    /// interface (eth0).
    associate_public_ip_address: ?bool = null,

    /// Information about the interface attachment. If modifying the `delete on
    /// termination` attribute, you must specify the ID of the interface
    /// attachment.
    attachment: ?NetworkInterfaceAttachmentChanges = null,

    /// A connection tracking specification.
    connection_tracking_specification: ?ConnectionTrackingSpecificationRequest = null,

    /// A description for the network interface.
    description: ?AttributeValue = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually
    /// making the request, and provides an error response. If you have the required
    /// permissions, the error response is `DryRunOperation`. Otherwise, it is
    /// `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// If you’re modifying a network interface in a dual-stack or IPv6-only subnet,
    /// you have
    /// the option to assign a primary IPv6 IP address. A primary IPv6 address is an
    /// IPv6 GUA
    /// address associated with an ENI that you have enabled to use a primary IPv6
    /// address. Use
    /// this option if the instance that this ENI will be attached to relies on its
    /// IPv6 address
    /// not changing. Amazon Web Services will automatically assign an IPv6 address
    /// associated
    /// with the ENI attached to your instance to be the primary IPv6 address. Once
    /// you enable
    /// an IPv6 GUA address to be a primary IPv6, you cannot disable it. When you
    /// enable an IPv6
    /// GUA address to be a primary IPv6, the first IPv6 GUA will be made the
    /// primary IPv6
    /// address until the instance is terminated or the network interface is
    /// detached. If you
    /// have multiple IPv6 addresses associated with an ENI attached to your
    /// instance and you
    /// enable a primary IPv6 address, the first IPv6 GUA address associated with
    /// the ENI
    /// becomes the primary IPv6 address.
    enable_primary_ipv_6: ?bool = null,

    /// Updates the ENA Express configuration for the network interface that’s
    /// attached to the
    /// instance.
    ena_srd_specification: ?EnaSrdSpecification = null,

    /// Changes the security groups for the network interface. The new set of groups
    /// you
    /// specify replaces the current set. You must specify at least one group, even
    /// if it's just
    /// the default security group in the VPC. You must specify the ID of the
    /// security group,
    /// not the name.
    groups: ?[]const []const u8 = null,

    /// The ID of the network interface.
    network_interface_id: []const u8,

    /// Enable or disable source/destination checks, which ensure that the instance
    /// is either
    /// the source or the destination of any traffic that it receives. If the value
    /// is
    /// `true`, source/destination checks are enabled; otherwise, they are
    /// disabled. The default value is `true`. You must disable source/destination
    /// checks if the instance runs services such as network address translation,
    /// routing, or
    /// firewalls.
    source_dest_check: ?AttributeBooleanValue = null,
};

pub const ModifyNetworkInterfaceAttributeOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyNetworkInterfaceAttributeOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyNetworkInterfaceAttributeInput, options: Options) !ModifyNetworkInterfaceAttributeOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyNetworkInterfaceAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyNetworkInterfaceAttribute&Version=2016-11-15");
    if (input.associated_subnet_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AssociatedSubnetId.AssociatedSubnetId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.associate_public_ip_address) |v| {
        try body_buf.appendSlice(alloc, "&AssociatePublicIpAddress=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.attachment) |v| {
        if (v.attachment_id) |sv| {
            try body_buf.appendSlice(alloc, "&Attachment.AttachmentId=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.default_ena_queue_count) |sv| {
            try body_buf.appendSlice(alloc, "&Attachment.DefaultEnaQueueCount=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.delete_on_termination) |sv| {
            try body_buf.appendSlice(alloc, "&Attachment.DeleteOnTermination=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.ena_queue_count) |sv| {
            try body_buf.appendSlice(alloc, "&Attachment.EnaQueueCount=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.connection_tracking_specification) |v| {
        if (v.tcp_established_timeout) |sv| {
            try body_buf.appendSlice(alloc, "&ConnectionTrackingSpecification.TcpEstablishedTimeout=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.udp_stream_timeout) |sv| {
            try body_buf.appendSlice(alloc, "&ConnectionTrackingSpecification.UdpStreamTimeout=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.udp_timeout) |sv| {
            try body_buf.appendSlice(alloc, "&ConnectionTrackingSpecification.UdpTimeout=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.description) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&Description.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_primary_ipv_6) |v| {
        try body_buf.appendSlice(alloc, "&EnablePrimaryIpv6=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ena_srd_specification) |v| {
        if (v.ena_srd_enabled) |sv| {
            try body_buf.appendSlice(alloc, "&EnaSrdSpecification.EnaSrdEnabled=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.ena_srd_udp_specification) |sv| {
            if (sv.ena_srd_udp_enabled) |sv2| {
                try body_buf.appendSlice(alloc, "&EnaSrdSpecification.EnaSrdUdpSpecification.EnaSrdUdpEnabled=");
                try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv2) "true" else "false");
            }
        }
    }
    if (input.groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupId.SecurityGroupId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    try body_buf.appendSlice(alloc, "&NetworkInterfaceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.network_interface_id);
    if (input.source_dest_check) |v| {
        if (v.value) |sv| {
            try body_buf.appendSlice(alloc, "&SourceDestCheck.Value=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyNetworkInterfaceAttributeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: ModifyNetworkInterfaceAttributeOutput = .{};

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
