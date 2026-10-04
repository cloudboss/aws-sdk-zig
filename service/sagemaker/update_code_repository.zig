const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GitConfigForUpdate = @import("git_config_for_update.zig").GitConfigForUpdate;

pub const UpdateCodeRepositoryInput = struct {
    /// The name of the Git repository to update.
    code_repository_name: []const u8,

    /// The configuration of the git repository, including the URL and the Amazon
    /// Resource Name (ARN) of the Amazon Web Services Secrets Manager secret that
    /// contains the credentials used to access the repository. The secret must have
    /// a staging label of `AWSCURRENT` and must be in the following format:
    ///
    /// `{"username": *UserName*, "password": *Password*}`
    git_config: ?GitConfigForUpdate = null,

    pub const json_field_names = .{
        .code_repository_name = "CodeRepositoryName",
        .git_config = "GitConfig",
    };
};

pub const UpdateCodeRepositoryOutput = struct {
    /// The ARN of the Git repository.
    code_repository_arn: []const u8,

    pub const json_field_names = .{
        .code_repository_arn = "CodeRepositoryArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCodeRepositoryInput, options: CallOptions) !UpdateCodeRepositoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCodeRepositoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateCodeRepository");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCodeRepositoryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateCodeRepositoryOutput, body, allocator);
}
