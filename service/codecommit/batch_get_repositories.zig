const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetRepositoriesError = @import("batch_get_repositories_error.zig").BatchGetRepositoriesError;
const RepositoryMetadata = @import("repository_metadata.zig").RepositoryMetadata;

pub const BatchGetRepositoriesInput = struct {
    /// The names of the repositories to get information about.
    ///
    /// The length constraint limit is for each string in the array. The array
    /// itself can be empty.
    repository_names: []const []const u8,

    pub const json_field_names = .{
        .repository_names = "repositoryNames",
    };
};

pub const BatchGetRepositoriesOutput = struct {
    /// Returns information about any errors returned when attempting to retrieve
    /// information about the repositories.
    errors: ?[]const BatchGetRepositoriesError = null,

    /// A list of repositories returned by the batch get repositories operation.
    repositories: ?[]const RepositoryMetadata = null,

    /// Returns a list of repository names for which information could not be found.
    repositories_not_found: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .errors = "errors",
        .repositories = "repositories",
        .repositories_not_found = "repositoriesNotFound",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetRepositoriesInput, options: CallOptions) !BatchGetRepositoriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecommit", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetRepositoriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecommit", "CodeCommit", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.BatchGetRepositories");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetRepositoriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetRepositoriesOutput, body, allocator);
}
