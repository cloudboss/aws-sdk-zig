const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyScope = @import("policy_scope.zig").PolicyScope;
const ResourcePolicy = @import("resource_policy.zig").ResourcePolicy;

pub const DescribeResourcePoliciesInput = struct {
    /// The maximum number of resource policies to be displayed with one call of
    /// this
    /// API.
    limit: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// Specifies the scope of the resource policy. Valid values are `ACCOUNT` or
    /// `RESOURCE`. When not specified, defaults to `ACCOUNT`.
    policy_scope: ?PolicyScope = null,

    /// The ARN of the CloudWatch Logs resource for which to query the resource
    /// policy.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "limit",
        .next_token = "nextToken",
        .policy_scope = "policyScope",
        .resource_arn = "resourceArn",
    };
};

pub const DescribeResourcePoliciesOutput = struct {
    next_token: ?[]const u8 = null,

    /// The resource policies that exist in this account.
    resource_policies: ?[]const ResourcePolicy = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .resource_policies = "resourcePolicies",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeResourcePoliciesInput, options: CallOptions) !DescribeResourcePoliciesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeResourcePoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DescribeResourcePolicies");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeResourcePoliciesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeResourcePoliciesOutput, body, allocator);
}
