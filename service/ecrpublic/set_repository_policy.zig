const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetRepositoryPolicyInput = struct {
    /// If the policy that you want to set on a repository policy would prevent you
    /// from setting
    /// another policy in the future, you must force the SetRepositoryPolicy
    /// operation. This prevents accidental repository lockouts.
    force: ?bool = null,

    /// The JSON repository policy text to apply to the repository. For more
    /// information, see
    /// [Amazon ECR Repository
    /// Policies](https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-policy-examples.html) in the *Amazon Elastic Container Registry User Guide*.
    policy_text: []const u8,

    /// The Amazon Web Services account ID that's associated with the registry that
    /// contains the repository.
    /// If you do not specify a registry, the default public registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name of the repository to receive the policy.
    repository_name: []const u8,

    pub const json_field_names = .{
        .force = "force",
        .policy_text = "policyText",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const SetRepositoryPolicyOutput = struct {
    /// The JSON repository policy text that's applied to the repository.
    policy_text: ?[]const u8 = null,

    /// The registry ID that's associated with the request.
    registry_id: ?[]const u8 = null,

    /// The repository name that's associated with the request.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_text = "policyText",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetRepositoryPolicyInput, options: CallOptions) !SetRepositoryPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr-public", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetRepositoryPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr-public", "ECR PUBLIC", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.SetRepositoryPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetRepositoryPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SetRepositoryPolicyOutput, body, allocator);
}
