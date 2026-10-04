const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeletePolicyInput = struct {
    /// If `True`, the request performs cleanup according to the policy type.
    ///
    /// For WAF and Shield Advanced policies, the cleanup does the following:
    ///
    /// * Deletes rule groups created by Firewall Manager
    ///
    /// * Removes web ACLs from in-scope resources
    ///
    /// * Deletes web ACLs that contain no rules or rule groups
    ///
    /// For security group policies, the cleanup does the following for each
    /// security group in
    /// the policy:
    ///
    /// * Disassociates the security group from in-scope resources
    ///
    /// * Deletes the security group if it was created through Firewall Manager and
    ///   if it's
    /// no longer associated with any resources through another policy
    ///
    /// For security group common policies, even if set to `False`, Firewall Manager
    /// deletes all security groups created by Firewall Manager that aren't
    /// associated with any other resources through another policy.
    ///
    /// After the cleanup, in-scope resources are no longer protected by web ACLs in
    /// this policy.
    /// Protection of out-of-scope resources remains unchanged. Scope is determined
    /// by tags that you
    /// create and accounts that you associate with the policy. When creating the
    /// policy, if you
    /// specify that only resources in specific accounts or with specific tags are
    /// in scope of the
    /// policy, those accounts and resources are handled by the policy. All others
    /// are out of scope.
    /// If you don't specify tags or accounts, all resources are in scope.
    delete_all_policy_resources: ?bool = null,

    /// The ID of the policy that you want to delete. You can retrieve this ID from
    /// `PutPolicy` and `ListPolicies`.
    policy_id: []const u8,

    pub const json_field_names = .{
        .delete_all_policy_resources = "DeleteAllPolicyResources",
        .policy_id = "PolicyId",
    };
};

pub const DeletePolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePolicyInput, options: CallOptions) !DeletePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.DeletePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
