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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyIpamScopeOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyIpamScopeInput, options: Options) !ModifyIpamScopeOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyIpamScopeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyIpamScope&Version=2016-11-15");
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.external_authority_configuration) |v| {
        if (v.external_resource_identifier) |sv| {
            try body_buf.appendSlice(alloc, "&ExternalAuthorityConfiguration.ExternalResourceIdentifier=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.@"type") |sv| {
            try body_buf.appendSlice(alloc, "&ExternalAuthorityConfiguration.Type=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    try body_buf.appendSlice(alloc, "&IpamScopeId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.ipam_scope_id);
    if (input.remove_external_authority_configuration) |v| {
        try body_buf.appendSlice(alloc, "&RemoveExternalAuthorityConfiguration=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyIpamScopeOutput {
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
                    result.ipam_scope = try serde.deserializeIpamScope(&reader, alloc);
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
