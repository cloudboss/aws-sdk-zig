const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutResourcePolicyInput = struct {
    /// Set this parameter to `true` to confirm that you want to remove your
    /// permissions to change the policy of this resource in the future.
    confirm_remove_self_resource_access: ?bool = null,

    /// A string value that you can use to conditionally update your policy. You can
    /// provide
    /// the revision ID of your existing policy to make mutating requests against
    /// that
    /// policy.
    ///
    /// When you provide an expected revision ID, if the revision ID of the existing
    /// policy on the resource doesn't match or if there's no policy attached to the
    /// resource, your request will be rejected with a
    /// `PolicyNotFoundException`.
    ///
    /// To conditionally attach a policy when no policy exists for the resource,
    /// specify
    /// `NO_POLICY` for the revision ID.
    expected_revision_id: ?[]const u8 = null,

    /// An Amazon Web Services resource-based policy document in JSON format.
    ///
    /// * The maximum size supported for a resource-based policy document is 20 KB.
    /// DynamoDB counts whitespaces when calculating the size of a policy
    /// against this limit.
    ///
    /// * Within a resource-based policy, if the action for a DynamoDB
    /// service-linked role (SLR) to replicate data for a global table is denied,
    /// adding
    /// or deleting a replica will fail with an error.
    ///
    /// For a full list of all considerations that apply while attaching a
    /// resource-based
    /// policy, see [Resource-based
    /// policy
    /// considerations](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/rbac-considerations.html).
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the DynamoDB resource to which the policy
    /// will be attached.
    /// The resources you can specify include tables and streams.
    ///
    /// You can control index permissions using the base table's policy. To specify
    /// the same permission level for your table and its indexes, you can provide
    /// both the table and index Amazon Resource Name (ARN)s in the `Resource` field
    /// of a given `Statement` in your policy document. Alternatively, to specify
    /// different permissions for your table, indexes, or both, you can define
    /// multiple `Statement` fields in your policy document.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .confirm_remove_self_resource_access = "ConfirmRemoveSelfResourceAccess",
        .expected_revision_id = "ExpectedRevisionId",
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// A unique string that represents the revision ID of the policy. If you're
    /// comparing revision IDs, make sure to always use string comparison logic.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .revision_id = "RevisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.PutResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutResourcePolicyOutput, body, allocator);
}
