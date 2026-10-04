const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Commit = @import("commit.zig").Commit;
const BatchGetCommitsError = @import("batch_get_commits_error.zig").BatchGetCommitsError;

pub const BatchGetCommitsInput = struct {
    /// The full commit IDs of the commits to get information about.
    ///
    /// You must supply the full SHA IDs of each commit. You cannot use shortened
    /// SHA
    /// IDs.
    commit_ids: []const []const u8,

    /// The name of the repository that contains the commits.
    repository_name: []const u8,

    pub const json_field_names = .{
        .commit_ids = "commitIds",
        .repository_name = "repositoryName",
    };
};

pub const BatchGetCommitsOutput = struct {
    /// An array of commit data type objects, each of which contains information
    /// about a specified commit.
    commits: ?[]const Commit = null,

    /// Returns any commit IDs for which information could not be found. For
    /// example, if one
    /// of the commit IDs was a shortened SHA ID or that commit was not found in the
    /// specified
    /// repository, the ID returns an error object with more information.
    errors: ?[]const BatchGetCommitsError = null,

    pub const json_field_names = .{
        .commits = "commits",
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetCommitsInput, options: CallOptions) !BatchGetCommitsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetCommitsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.BatchGetCommits");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetCommitsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetCommitsOutput, body, allocator);
}
