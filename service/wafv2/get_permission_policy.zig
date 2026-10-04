const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetPermissionPolicyInput = struct {
    /// The Amazon Resource Name (ARN) of the rule group for which you want to get
    /// the
    /// policy.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};

pub const GetPermissionPolicyOutput = struct {
    /// The IAM policy that is attached to the specified rule group.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPermissionPolicyInput, options: CallOptions) !GetPermissionPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wafv2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPermissionPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.GetPermissionPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPermissionPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPermissionPolicyOutput, body, allocator);
}
