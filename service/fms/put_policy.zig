const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Policy = @import("policy.zig").Policy;
const Tag = @import("tag.zig").Tag;

pub const PutPolicyInput = struct {
    /// The details of the Firewall Manager policy to be created.
    policy: Policy,

    /// The tags to add to the Amazon Web Services resource.
    tag_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .policy = "Policy",
        .tag_list = "TagList",
    };
};

pub const PutPolicyOutput = struct {
    /// The details of the Firewall Manager policy.
    policy: ?Policy = null,

    /// The Amazon Resource Name (ARN) of the policy.
    policy_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
        .policy_arn = "PolicyArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutPolicyInput, options: CallOptions) !PutPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.PutPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutPolicyOutput, body, allocator);
}
