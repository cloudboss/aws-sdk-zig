const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteResourcePolicyInput = struct {
    /// A string value that you can use to conditionally delete your policy. When
    /// you provide
    /// an expected revision ID, if the revision ID of the existing policy on the
    /// resource
    /// doesn't match or if there's no policy attached to the resource, the request
    /// will fail
    /// and return a `PolicyNotFoundException`.
    expected_revision_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the DynamoDB resource from which the
    /// policy will be
    /// removed. The resources you can specify include tables and streams. If you
    /// remove the
    /// policy of a table, it will also remove the permissions for the table's
    /// indexes defined
    /// in that policy document. This is because index permissions are defined in
    /// the table's
    /// policy.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .expected_revision_id = "ExpectedRevisionId",
        .resource_arn = "ResourceArn",
    };
};

pub const DeleteResourcePolicyOutput = struct {
    /// A unique string that represents the revision ID of the policy. If you're
    /// comparing revision IDs, make sure to always use string comparison logic.
    ///
    /// This value will be empty if you make a request against a resource without a
    /// policy.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .revision_id = "RevisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteResourcePolicyInput, options: CallOptions) !DeleteResourcePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteResourcePolicyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.DeleteResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteResourcePolicyOutput, body, allocator);
}
