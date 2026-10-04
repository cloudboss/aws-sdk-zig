const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeletePullThroughCacheRuleInput = struct {
    /// The Amazon ECR repository prefix associated with the pull through cache rule
    /// to
    /// delete.
    ecr_repository_prefix: []const u8,

    /// The Amazon Web Services account ID associated with the registry that
    /// contains the pull through cache
    /// rule. If you do not specify a registry, the default registry is assumed.
    registry_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ecr_repository_prefix = "ecrRepositoryPrefix",
        .registry_id = "registryId",
    };
};

pub const DeletePullThroughCacheRuleOutput = struct {
    /// The timestamp associated with the pull through cache rule.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret associated with the pull through cache
    /// rule.
    credential_arn: ?[]const u8 = null,

    /// The ARN of the IAM role associated with the pull through cache rule.
    custom_role_arn: ?[]const u8 = null,

    /// The Amazon ECR repository prefix associated with the request.
    ecr_repository_prefix: ?[]const u8 = null,

    /// The registry ID associated with the request.
    registry_id: ?[]const u8 = null,

    /// The upstream registry URL associated with the pull through cache rule.
    upstream_registry_url: ?[]const u8 = null,

    /// The upstream repository prefix associated with the pull through cache rule.
    upstream_repository_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .credential_arn = "credentialArn",
        .custom_role_arn = "customRoleArn",
        .ecr_repository_prefix = "ecrRepositoryPrefix",
        .registry_id = "registryId",
        .upstream_registry_url = "upstreamRegistryUrl",
        .upstream_repository_prefix = "upstreamRepositoryPrefix",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePullThroughCacheRuleInput, options: CallOptions) !DeletePullThroughCacheRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePullThroughCacheRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr", "ECR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.DeletePullThroughCacheRule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePullThroughCacheRuleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeletePullThroughCacheRuleOutput, body, allocator);
}
