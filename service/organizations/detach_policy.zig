const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DetachPolicyInput = struct {
    /// ID for the policy you want to detach. You can get the ID from the
    /// ListPolicies or ListPoliciesForTarget
    /// operations.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a policy ID string
    /// requires "p-" followed
    /// by from 8 to 128 lowercase or uppercase letters, digits, or the underscore
    /// character (_).
    policy_id: []const u8,

    /// ID for the root, OU, or account that you want to detach the policy from. You
    /// can get
    /// the ID from the ListRoots, ListOrganizationalUnitsForParent, or ListAccounts
    /// operations.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a target ID string
    /// requires one of the
    /// following:
    ///
    /// * **Root** - A string that begins with "r-" followed by from 4 to 32
    ///   lowercase letters or
    /// digits.
    ///
    /// * **Account** - A string that consists of exactly 12 digits.
    ///
    /// * **Organizational unit (OU)** - A string that begins with "ou-" followed by
    ///   from 4 to 32
    /// lowercase letters or digits (the ID of the root that the OU is in). This
    /// string is followed by a second
    /// "-" dash and from 8 to 32 additional lowercase letters or digits.
    target_id: []const u8,

    pub const json_field_names = .{
        .policy_id = "PolicyId",
        .target_id = "TargetId",
    };
};

pub const DetachPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetachPolicyInput, options: CallOptions) !DetachPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetachPolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.DetachPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetachPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
