const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetResourcePolicyInput = struct {
    /// The ARN of the Glue resource for which to retrieve the resource policy. If
    /// not
    /// supplied, the Data Catalog resource policy is returned. Use
    /// `GetResourcePolicies`
    /// to view all existing resource policies. For more information see [Specifying
    /// Glue Resource
    /// ARNs](https://docs.aws.amazon.com/glue/latest/dg/glue-specifying-resource-arns.html).
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};

pub const GetResourcePolicyOutput = struct {
    /// The date and time at which the policy was created.
    create_time: ?i64 = null,

    /// Contains the hash value associated with this policy.
    policy_hash: ?[]const u8 = null,

    /// Contains the requested policy document, in JSON format.
    policy_in_json: ?[]const u8 = null,

    /// The date and time at which the policy was last updated.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .policy_hash = "PolicyHash",
        .policy_in_json = "PolicyInJson",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourcePolicyInput, options: CallOptions) !GetResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourcePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetResourcePolicyOutput, body, allocator);
}
