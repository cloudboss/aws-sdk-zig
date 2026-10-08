const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessPolicyType = @import("access_policy_type.zig").AccessPolicyType;
const AccessPolicyDetail = @import("access_policy_detail.zig").AccessPolicyDetail;

pub const UpdateAccessPolicyInput = struct {
    /// Unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// A description of the policy. Typically used to store information about the
    /// permissions defined in the policy.
    description: ?[]const u8 = null,

    /// The name of the policy.
    name: []const u8,

    /// The JSON policy document to use as the content for the policy.
    policy: ?[]const u8 = null,

    /// The version of the policy being updated.
    policy_version: []const u8,

    /// The type of policy.
    type: AccessPolicyType,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .name = "name",
        .policy = "policy",
        .policy_version = "policyVersion",
        .type = "type",
    };
};

pub const UpdateAccessPolicyOutput = struct {
    /// Details about the updated access policy.
    access_policy_detail: ?AccessPolicyDetail = null,

    pub const json_field_names = .{
        .access_policy_detail = "accessPolicyDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccessPolicyInput, options: CallOptions) !UpdateAccessPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccessPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.UpdateAccessPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccessPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateAccessPolicyOutput, body, allocator);
}
