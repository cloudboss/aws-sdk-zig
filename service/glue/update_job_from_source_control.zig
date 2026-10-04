const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceControlAuthStrategy = @import("source_control_auth_strategy.zig").SourceControlAuthStrategy;
const SourceControlProvider = @import("source_control_provider.zig").SourceControlProvider;

pub const UpdateJobFromSourceControlInput = struct {
    /// The type of authentication, which can be an authentication token stored in
    /// Amazon Web Services Secrets Manager, or a personal access token.
    auth_strategy: ?SourceControlAuthStrategy = null,

    /// The value of the authorization token.
    auth_token: ?[]const u8 = null,

    /// An optional branch in the remote repository.
    branch_name: ?[]const u8 = null,

    /// A commit ID for a commit in the remote repository.
    commit_id: ?[]const u8 = null,

    /// An optional folder in the remote repository.
    folder: ?[]const u8 = null,

    /// The name of the Glue job to be synchronized to or from the remote
    /// repository.
    job_name: ?[]const u8 = null,

    /// The provider for the remote repository. Possible values: GITHUB,
    /// AWS_CODE_COMMIT, GITLAB, BITBUCKET.
    provider: ?SourceControlProvider = null,

    /// The name of the remote repository that contains the job artifacts.
    /// For BitBucket providers, `RepositoryName` should include `WorkspaceName`.
    /// Use the format `/`.
    repository_name: ?[]const u8 = null,

    /// The owner of the remote repository that contains the job artifacts.
    repository_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_strategy = "AuthStrategy",
        .auth_token = "AuthToken",
        .branch_name = "BranchName",
        .commit_id = "CommitId",
        .folder = "Folder",
        .job_name = "JobName",
        .provider = "Provider",
        .repository_name = "RepositoryName",
        .repository_owner = "RepositoryOwner",
    };
};

pub const UpdateJobFromSourceControlOutput = struct {
    /// The name of the Glue job.
    job_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_name = "JobName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateJobFromSourceControlInput, options: CallOptions) !UpdateJobFromSourceControlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateJobFromSourceControlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.UpdateJobFromSourceControl");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateJobFromSourceControlOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateJobFromSourceControlOutput, body, allocator);
}
