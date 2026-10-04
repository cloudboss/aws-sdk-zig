const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Repository = @import("repository.zig").Repository;

pub const DeleteRepositoryInput = struct {
    /// If true, deleting the repository force deletes the contents of the
    /// repository. If
    /// false, the repository must be empty before attempting to delete it.
    force: ?bool = null,

    /// The Amazon Web Services account ID associated with the registry that
    /// contains the repository to
    /// delete. If you do not specify a registry, the default registry is assumed.
    registry_id: ?[]const u8 = null,

    /// The name of the repository to delete.
    repository_name: []const u8,

    pub const json_field_names = .{
        .force = "force",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};

pub const DeleteRepositoryOutput = struct {
    /// The repository that was deleted.
    repository: ?Repository = null,

    pub const json_field_names = .{
        .repository = "repository",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRepositoryInput, options: CallOptions) !DeleteRepositoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRepositoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.DeleteRepository");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRepositoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteRepositoryOutput, body, allocator);
}
