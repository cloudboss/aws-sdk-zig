const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Protection = @import("protection.zig").Protection;

pub const DescribeProtectionInput = struct {
    /// The unique identifier (ID) for the Protection object to describe.
    /// You must provide either the `ResourceArn` of the protected resource or the
    /// `ProtectionID` of the protection, but not both.
    protection_id: ?[]const u8 = null,

    /// The ARN (Amazon Resource Name) of the protected Amazon Web Services
    /// resource.
    /// You must provide either the `ResourceArn` of the protected resource or the
    /// `ProtectionID` of the protection, but not both.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .protection_id = "ProtectionId",
        .resource_arn = "ResourceArn",
    };
};

pub const DescribeProtectionOutput = struct {
    /// The Protection that you requested.
    protection: ?Protection = null,

    pub const json_field_names = .{
        .protection = "Protection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProtectionInput, options: CallOptions) !DescribeProtectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "shield", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProtectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("shield", "Shield", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShield_20160616.DescribeProtection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProtectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeProtectionOutput, body, allocator);
}
