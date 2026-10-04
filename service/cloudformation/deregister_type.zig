const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistryType = @import("registry_type.zig").RegistryType;

pub const DeregisterTypeInput = struct {
    /// The Amazon Resource Name (ARN) of the extension.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    arn: ?[]const u8 = null,

    /// The kind of extension.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    @"type": ?RegistryType = null,

    /// The name of the extension.
    ///
    /// Conditional: You must specify either `TypeName` and `Type`, or
    /// `Arn`.
    type_name: ?[]const u8 = null,

    /// The ID of a specific version of the extension. The version ID is the value
    /// at the end of
    /// the Amazon Resource Name (ARN) assigned to the extension version when it is
    /// registered.
    version_id: ?[]const u8 = null,
};

pub const DeregisterTypeOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeregisterTypeInput, options: CallOptions) !DeregisterTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DeregisterTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeregisterType&Version=2010-05-15");
    if (input.arn) |v| {
        try body_buf.appendSlice(allocator, "&Arn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.@"type") |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.type_name) |v| {
        try body_buf.appendSlice(allocator, "&TypeName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.version_id) |v| {
        try body_buf.appendSlice(allocator, "&VersionId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeregisterTypeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: DeregisterTypeOutput = .{};

    return result;
}
