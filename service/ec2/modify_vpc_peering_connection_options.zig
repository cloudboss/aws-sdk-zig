const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PeeringConnectionOptionsRequest = @import("peering_connection_options_request.zig").PeeringConnectionOptionsRequest;
const PeeringConnectionOptions = @import("peering_connection_options.zig").PeeringConnectionOptions;

/// Modifies the VPC peering connection options on one side of a VPC peering
/// connection.
///
/// If the peered VPCs are in the same Amazon Web Services account, you can
/// enable DNS
/// resolution for queries from the local VPC. This ensures that queries from
/// the local VPC
/// resolve to private IP addresses in the peer VPC. This option is not
/// available if the
/// peered VPCs are in different Amazon Web Services accounts or different
/// Regions. For
/// peered VPCs in different Amazon Web Services accounts, each Amazon Web
/// Services account
/// owner must initiate a separate request to modify the peering connection
/// options. For
/// inter-region peering connections, you must use the Region for the requester
/// VPC to
/// modify the requester VPC peering options and the Region for the accepter VPC
/// to modify
/// the accepter VPC peering options. To verify which VPCs are the accepter and
/// the
/// requester for a VPC peering connection, use the
/// DescribeVpcPeeringConnections command.
pub const ModifyVpcPeeringConnectionOptionsInput = struct {
    /// The VPC peering connection options for the accepter VPC.
    accepter_peering_connection_options: ?PeeringConnectionOptionsRequest = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The VPC peering connection options for the requester VPC.
    requester_peering_connection_options: ?PeeringConnectionOptionsRequest = null,

    /// The ID of the VPC peering connection.
    vpc_peering_connection_id: []const u8,
};

pub const ModifyVpcPeeringConnectionOptionsOutput = struct {
    /// Information about the VPC peering connection options for the accepter VPC.
    accepter_peering_connection_options: ?PeeringConnectionOptions = null,

    /// Information about the VPC peering connection options for the requester VPC.
    requester_peering_connection_options: ?PeeringConnectionOptions = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ModifyVpcPeeringConnectionOptionsOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyVpcPeeringConnectionOptionsInput, options: Options) !ModifyVpcPeeringConnectionOptionsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVpcPeeringConnectionOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVpcPeeringConnectionOptions&Version=2016-11-15");
    if (input.accepter_peering_connection_options) |v| {
        if (v.allow_dns_resolution_from_remote_vpc) |sv| {
            try body_buf.appendSlice(alloc, "&AccepterPeeringConnectionOptions.AllowDnsResolutionFromRemoteVpc=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.allow_egress_from_local_classic_link_to_remote_vpc) |sv| {
            try body_buf.appendSlice(alloc, "&AccepterPeeringConnectionOptions.AllowEgressFromLocalClassicLinkToRemoteVpc=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.allow_egress_from_local_vpc_to_remote_classic_link) |sv| {
            try body_buf.appendSlice(alloc, "&AccepterPeeringConnectionOptions.AllowEgressFromLocalVpcToRemoteClassicLink=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.requester_peering_connection_options) |v| {
        if (v.allow_dns_resolution_from_remote_vpc) |sv| {
            try body_buf.appendSlice(alloc, "&RequesterPeeringConnectionOptions.AllowDnsResolutionFromRemoteVpc=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.allow_egress_from_local_classic_link_to_remote_vpc) |sv| {
            try body_buf.appendSlice(alloc, "&RequesterPeeringConnectionOptions.AllowEgressFromLocalClassicLinkToRemoteVpc=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.allow_egress_from_local_vpc_to_remote_classic_link) |sv| {
            try body_buf.appendSlice(alloc, "&RequesterPeeringConnectionOptions.AllowEgressFromLocalVpcToRemoteClassicLink=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    try body_buf.appendSlice(alloc, "&VpcPeeringConnectionId=");
    try appendUrlEncoded(alloc, &body_buf, input.vpc_peering_connection_id);

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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ModifyVpcPeeringConnectionOptionsOutput {
    _ = status;
    _ = body;
    const result: ModifyVpcPeeringConnectionOptionsOutput = .{ .allocator = alloc };

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
