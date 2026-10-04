const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProtectionGroup = @import("protection_group.zig").ProtectionGroup;

pub const DescribeProtectionGroupInput = struct {
    /// The name of the protection group. You use this to identify the protection
    /// group in lists and to manage the protection group, for example to update,
    /// delete, or describe it.
    protection_group_id: []const u8,

    pub const json_field_names = .{
        .protection_group_id = "ProtectionGroupId",
    };
};

pub const DescribeProtectionGroupOutput = struct {
    /// A grouping of protected resources that you and Shield Advanced can monitor
    /// as a collective. This resource grouping improves the accuracy of detection
    /// and reduces false positives.
    protection_group: ?ProtectionGroup = null,

    pub const json_field_names = .{
        .protection_group = "ProtectionGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProtectionGroupInput, options: CallOptions) !DescribeProtectionGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProtectionGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSShield_20160616.DescribeProtectionGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProtectionGroupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeProtectionGroupOutput, body, allocator);
}
