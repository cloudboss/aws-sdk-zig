const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcePolicy = @import("resource_policy.zig").ResourcePolicy;

pub const PutResourcePolicyInput = struct {
    /// The policy to create or update. For example, the following policy grants a
    /// user authorization to restore a snapshot.
    ///
    /// `"{\"Version\": \"2012-10-17\", \"Statement\" : [{ \"Sid\":
    /// \"AllowUserRestoreFromSnapshot\", \"Principal\":{\"AWS\":
    /// [\"739247239426\"]}, \"Action\":
    /// [\"redshift-serverless:RestoreFromSnapshot\"] , \"Effect\": \"Allow\" }]}"`
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the account to create or update a resource
    /// policy for.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "policy",
        .resource_arn = "resourceArn",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// The policy that was created or updated.
    resource_policy: ?ResourcePolicy = null,

    pub const json_field_names = .{
        .resource_policy = "resourcePolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.PutResourcePolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutResourcePolicyOutput, body, allocator);
}
