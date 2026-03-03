const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExternalAuthorityConfiguration = @import("external_authority_configuration.zig").ExternalAuthorityConfiguration;
const IpamScope = @import("ipam_scope.zig").IpamScope;
const serde = @import("serde.zig");

pub const ModifyIpamScopeInput = struct {
    /// The description of the scope you want to modify.
    description: ?[]const u8 = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The configuration that links an Amazon VPC IPAM scope to an external
    /// authority system. It specifies the type of external system and the external
    /// resource identifier that identifies your account or instance in that system.
    ///
    /// In IPAM, an external authority is a third-party IP address management system
    /// that provides CIDR blocks when you provision address space for top-level
    /// IPAM pools. This allows you to use your existing IP management system to
    /// control which address ranges are allocated to Amazon Web Services while
    /// using Amazon VPC IPAM to manage subnets within those ranges.
    external_authority_configuration: ?ExternalAuthorityConfiguration = null,

    /// The ID of the scope you want to modify.
    ipam_scope_id: []const u8,

    /// Remove the external authority configuration. `true` to remove.
    remove_external_authority_configuration: ?bool = null,
};

pub const ModifyIpamScopeOutput = struct {
    /// The results of the modification.
    ipam_scope: ?IpamScope = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyIpamScopeInput, options: Options) !ModifyIpamScopeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyIpamScopeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyIpamScope&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.external_authority_configuration) |v| {
        if (v.external_resource_identifier) |sv| {
            try body_buf.appendSlice(allocator, "&ExternalAuthorityConfiguration.ExternalResourceIdentifier=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.@"type") |sv| {
            try body_buf.appendSlice(allocator, "&ExternalAuthorityConfiguration.Type=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
    }
    try body_buf.appendSlice(allocator, "&IpamScopeId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ipam_scope_id);
    if (input.remove_external_authority_configuration) |v| {
        try body_buf.appendSlice(allocator, "&RemoveExternalAuthorityConfiguration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyIpamScopeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyIpamScopeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamScope")) {
                    result.ipam_scope = try serde.deserializeIpamScope(allocator, &reader);
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
