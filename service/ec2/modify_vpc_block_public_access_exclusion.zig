const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InternetGatewayExclusionMode = @import("internet_gateway_exclusion_mode.zig").InternetGatewayExclusionMode;
const VpcBlockPublicAccessExclusion = @import("vpc_block_public_access_exclusion.zig").VpcBlockPublicAccessExclusion;
const serde = @import("serde.zig");

/// Modify VPC Block Public Access (BPA) exclusions. A VPC BPA exclusion is a
/// mode that can be applied to a single VPC or subnet that exempts it from the
/// account’s BPA mode and will allow bidirectional or egress-only access. You
/// can create BPA exclusions for VPCs and subnets even when BPA is not enabled
/// on the account to ensure that there is no traffic disruption to the
/// exclusions when VPC BPA is turned on.
pub const ModifyVpcBlockPublicAccessExclusionInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of an exclusion.
    exclusion_id: []const u8,

    /// The exclusion mode for internet gateway traffic.
    ///
    /// * `allow-bidirectional`: Allow all internet traffic to and from the excluded
    ///   VPCs and subnets.
    ///
    /// * `allow-egress`: Allow outbound internet traffic from the excluded VPCs and
    ///   subnets. Block inbound internet traffic to the excluded VPCs and subnets.
    ///   Only applies when VPC Block Public Access is set to Bidirectional.
    internet_gateway_exclusion_mode: InternetGatewayExclusionMode,
};

pub const ModifyVpcBlockPublicAccessExclusionOutput = struct {
    /// Details related to the exclusion.
    vpc_block_public_access_exclusion: ?VpcBlockPublicAccessExclusion = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyVpcBlockPublicAccessExclusionOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyVpcBlockPublicAccessExclusionInput, options: Options) !ModifyVpcBlockPublicAccessExclusionOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVpcBlockPublicAccessExclusionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVpcBlockPublicAccessExclusion&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&ExclusionId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.exclusion_id);
    try body_buf.appendSlice(alloc, "&InternetGatewayExclusionMode=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.internet_gateway_exclusion_mode));

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyVpcBlockPublicAccessExclusionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVpcBlockPublicAccessExclusionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "vpcBlockPublicAccessExclusion")) {
                    result.vpc_block_public_access_exclusion = try serde.deserializeVpcBlockPublicAccessExclusion(&reader, alloc);
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
