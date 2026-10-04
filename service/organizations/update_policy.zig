const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Policy = @import("policy.zig").Policy;

pub const UpdatePolicyInput = struct {
    /// If provided, the new content for the policy. The text must be correctly
    /// formatted JSON
    /// that complies with the syntax for the policy's type. For more information,
    /// see [SCP
    /// syntax](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_syntax.html) in the *Organizations User Guide*.
    ///
    /// The maximum size of a policy document depends on the policy's type. For more
    /// information, see [Maximum and minimum
    /// values](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_reference_limits.html#min-max-values) in the
    /// *Organizations User Guide*.
    content: ?[]const u8 = null,

    /// If provided, the new description for the policy.
    description: ?[]const u8 = null,

    /// If provided, the new name for the policy.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// that is used to validate this parameter is a string of any of the characters
    /// in the ASCII
    /// character range.
    name: ?[]const u8 = null,

    /// ID for the policy that you want to update.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a policy ID string
    /// requires "p-" followed
    /// by from 8 to 128 lowercase or uppercase letters, digits, or the underscore
    /// character (_).
    policy_id: []const u8,

    pub const json_field_names = .{
        .content = "Content",
        .description = "Description",
        .name = "Name",
        .policy_id = "PolicyId",
    };
};

pub const UpdatePolicyOutput = struct {
    /// A structure that contains details about the updated policy, showing the
    /// requested
    /// changes.
    policy: ?Policy = null,

    pub const json_field_names = .{
        .policy = "Policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePolicyInput, options: CallOptions) !UpdatePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.UpdatePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePolicyOutput, body, allocator);
}
