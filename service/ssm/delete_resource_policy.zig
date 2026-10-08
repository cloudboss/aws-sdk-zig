const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeletionMode = @import("deletion_mode.zig").DeletionMode;

pub const DeleteResourcePolicyInput = struct {
    /// Specifies the intended outcome of the operation. Applies only to the
    /// `Document`
    /// resource type. The operation ignores this parameter for other resource
    /// types. Optional. Defaults
    /// to `RemoveSharing`.
    ///
    /// * `RemoveSharing` – Deletes the resource policy and removes sharing of the
    /// document.
    ///
    /// * `RollbackMigration` – Reverts the document to Custom sharing, preserving
    /// existing consumer access, instead of removing the policy.
    deletion_mode: ?DeletionMode = null,

    /// ID of the current policy version. The hash helps to prevent multiple calls
    /// from attempting
    /// to overwrite a policy.
    policy_hash: []const u8,

    /// The policy ID.
    policy_id: []const u8,

    /// Amazon Resource Name (ARN) of the resource to which the policies are
    /// attached.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .deletion_mode = "DeletionMode",
        .policy_hash = "PolicyHash",
        .policy_id = "PolicyId",
        .resource_arn = "ResourceArn",
    };
};

pub const DeleteResourcePolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteResourcePolicyInput, options: CallOptions) !DeleteResourcePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteResourcePolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DeleteResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteResourcePolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
