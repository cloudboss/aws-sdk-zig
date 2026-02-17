const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PeeringConnectionOptionsRequest = @import("peering_connection_options_request.zig").PeeringConnectionOptionsRequest;
const PeeringConnectionOptions = @import("peering_connection_options.zig").PeeringConnectionOptions;
const serde = @import("serde.zig");

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyVpcPeeringConnectionOptionsOutput) void {
        self._arena.deinit();
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVpcPeeringConnectionOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVpcPeeringConnectionOptions&Version=2016-11-15");
    if (input.accepter_peering_connection_options) |v| {
        if (v.allow_dns_resolution_from_remote_vpc) |sv| {
            try body_buf.appendSlice(alloc, "&AccepterPeeringConnectionOptions.AllowDnsResolutionFromRemoteVpc=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.allow_egress_from_local_classic_link_to_remote_vpc) |sv| {
            try body_buf.appendSlice(alloc, "&AccepterPeeringConnectionOptions.AllowEgressFromLocalClassicLinkToRemoteVpc=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.allow_egress_from_local_vpc_to_remote_classic_link) |sv| {
            try body_buf.appendSlice(alloc, "&AccepterPeeringConnectionOptions.AllowEgressFromLocalVpcToRemoteClassicLink=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.requester_peering_connection_options) |v| {
        if (v.allow_dns_resolution_from_remote_vpc) |sv| {
            try body_buf.appendSlice(alloc, "&RequesterPeeringConnectionOptions.AllowDnsResolutionFromRemoteVpc=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.allow_egress_from_local_classic_link_to_remote_vpc) |sv| {
            try body_buf.appendSlice(alloc, "&RequesterPeeringConnectionOptions.AllowEgressFromLocalClassicLinkToRemoteVpc=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.allow_egress_from_local_vpc_to_remote_classic_link) |sv| {
            try body_buf.appendSlice(alloc, "&RequesterPeeringConnectionOptions.AllowEgressFromLocalVpcToRemoteClassicLink=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
    }
    try body_buf.appendSlice(alloc, "&VpcPeeringConnectionId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.vpc_peering_connection_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyVpcPeeringConnectionOptionsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVpcPeeringConnectionOptionsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "accepterPeeringConnectionOptions")) {
                    result.accepter_peering_connection_options = try serde.deserializePeeringConnectionOptions(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "requesterPeeringConnectionOptions")) {
                    result.requester_peering_connection_options = try serde.deserializePeeringConnectionOptions(&reader, alloc);
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
