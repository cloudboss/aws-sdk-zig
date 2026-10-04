const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyType = @import("policy_type.zig").PolicyType;
const AccountPolicy = @import("account_policy.zig").AccountPolicy;

pub const DescribeAccountPoliciesInput = struct {
    /// If you are using an account that is set up as a monitoring account for
    /// CloudWatch
    /// unified cross-account observability, you can use this to specify the account
    /// ID of a source
    /// account. If you do, the operation returns the account policy for the
    /// specified account.
    /// Currently, you can specify only one account ID in this parameter.
    ///
    /// If you omit this parameter, only the policy in the current account is
    /// returned.
    account_identifiers: ?[]const []const u8 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// Use this parameter to limit the returned policies to only the policy with
    /// the name that
    /// you specify.
    policy_name: ?[]const u8 = null,

    /// Use this parameter to limit the returned policies to only the policies that
    /// match the
    /// policy type that you specify.
    policy_type: PolicyType,

    pub const json_field_names = .{
        .account_identifiers = "accountIdentifiers",
        .next_token = "nextToken",
        .policy_name = "policyName",
        .policy_type = "policyType",
    };
};

pub const DescribeAccountPoliciesOutput = struct {
    /// An array of structures that contain information about the CloudWatch Logs
    /// account
    /// policies that match the specified filters.
    account_policies: ?[]const AccountPolicy = null,

    /// The token to use when requesting the next set of items. The token expires
    /// after 24
    /// hours.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_policies = "accountPolicies",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAccountPoliciesInput, options: CallOptions) !DescribeAccountPoliciesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAccountPoliciesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DescribeAccountPolicies");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAccountPoliciesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAccountPoliciesOutput, body, allocator);
}
