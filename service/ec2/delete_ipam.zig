const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Ipam = @import("ipam.zig").Ipam;
const serde = @import("serde.zig");

/// Delete an IPAM. Deleting an IPAM removes all monitored data associated with
/// the IPAM including the historical data for CIDRs.
///
/// For more information, see [Delete an
/// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/delete-ipam.html) in the
/// *Amazon VPC IPAM User Guide*.
pub const DeleteIpamInput = struct {
    /// Enables you to quickly delete an IPAM, private scopes, pools in private
    /// scopes, and
    /// any allocations in the pools in private scopes. You cannot delete the IPAM
    /// with this option if there is a pool in your public scope. If you use this
    /// option, IPAM does the following:
    ///
    /// * Deallocates any CIDRs allocated to VPC resources (such as VPCs) in pools
    ///   in private scopes.
    ///
    /// **Note:**
    ///
    /// No VPC resources are deleted as a result of enabling this option. The CIDR
    /// associated with the resource will no longer be allocated from an IPAM pool,
    /// but the CIDR itself will remain unchanged.
    ///
    /// * Deprovisions all IPv4 CIDRs provisioned to IPAM pools in private scopes.
    ///
    /// * Deletes all IPAM pools in private scopes.
    ///
    /// * Deletes all non-default private scopes in the IPAM.
    ///
    /// * Deletes the default public and private scopes and the IPAM.
    cascade: ?bool = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the IPAM to delete.
    ipam_id: []const u8,
};

pub const DeleteIpamOutput = struct {
    /// Information about the results of the deletion.
    ipam: ?Ipam = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DeleteIpamOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DeleteIpamInput, options: Options) !DeleteIpamOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DeleteIpamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DeleteIpam&Version=2016-11-15");
    if (input.cascade) |v| {
        try body_buf.appendSlice(alloc, "&Cascade=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&IpamId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.ipam_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DeleteIpamOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DeleteIpamOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipam")) {
                    result.ipam = try serde.deserializeIpam(&reader, alloc);
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
