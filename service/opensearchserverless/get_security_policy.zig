const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SecurityPolicyType = @import("security_policy_type.zig").SecurityPolicyType;
const SecurityPolicyDetail = @import("security_policy_detail.zig").SecurityPolicyDetail;

pub const GetSecurityPolicyInput = struct {
    /// The name of the security policy.
    name: []const u8,

    /// The type of security policy.
    @"type": SecurityPolicyType,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
    };
};

pub const GetSecurityPolicyOutput = struct {
    /// Details about the requested security policy.
    security_policy_detail: ?SecurityPolicyDetail = null,

    pub const json_field_names = .{
        .security_policy_detail = "securityPolicyDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSecurityPolicyInput, options: CallOptions) !GetSecurityPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aoss", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSecurityPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aoss", "OpenSearchServerless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.GetSecurityPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSecurityPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSecurityPolicyOutput, body, allocator);
}
