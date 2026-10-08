const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutResourcePolicyInput = struct {
    /// A policy you want to associate with a resource.
    policy: []const u8,

    /// ID of the current policy version. The hash helps to prevent a situation
    /// where multiple users
    /// attempt to overwrite a policy. You must provide this hash when updating or
    /// deleting a
    /// policy.
    policy_hash: ?[]const u8 = null,

    /// The policy ID.
    policy_id: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the resource to which you want to attach a
    /// policy.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .policy_hash = "PolicyHash",
        .policy_id = "PolicyId",
        .resource_arn = "ResourceArn",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// ID of the current policy version.
    policy_hash: ?[]const u8 = null,

    /// The policy ID. To update a policy, you must specify `PolicyId` and
    /// `PolicyHash`.
    policy_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_hash = "PolicyHash",
        .policy_id = "PolicyId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResourcePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.PutResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutResourcePolicyOutput, body, allocator);
}
