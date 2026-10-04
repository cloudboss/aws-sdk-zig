const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryCatalogDataInput = @import("repository_catalog_data_input.zig").RepositoryCatalogDataInput;
const Tag = @import("tag.zig").Tag;
const RepositoryCatalogData = @import("repository_catalog_data.zig").RepositoryCatalogData;
const Repository = @import("repository.zig").Repository;

pub const CreateRepositoryInput = struct {
    /// The details about the repository that are publicly visible in the
    /// Amazon ECR Public Gallery.
    catalog_data: ?RepositoryCatalogDataInput = null,

    /// The name to use for the repository. This appears publicly in the Amazon ECR
    /// Public Gallery.
    /// The repository name can be specified on its own (for example
    /// `nginx-web-app`) or
    /// prepended with a namespace to group the repository into a category (for
    /// example
    /// `project-a/nginx-web-app`).
    repository_name: []const u8,

    /// The metadata that you apply to each repository to help categorize and
    /// organize your
    /// repositories. Each tag consists of a key and an optional value. You define
    /// both of them.
    /// Tag keys can have a maximum character length of 128 characters, and tag
    /// values can have a maximum length of 256 characters.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .catalog_data = "catalogData",
        .repository_name = "repositoryName",
        .tags = "tags",
    };
};

pub const CreateRepositoryOutput = struct {
    catalog_data: ?RepositoryCatalogData = null,

    /// The repository that was created.
    repository: ?Repository = null,

    pub const json_field_names = .{
        .catalog_data = "catalogData",
        .repository = "repository",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRepositoryInput, options: CallOptions) !CreateRepositoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRepositoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SpencerFrontendService.CreateRepository");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRepositoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRepositoryOutput, body, allocator);
}
