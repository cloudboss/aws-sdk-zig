const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileVersion = @import("file_version.zig").FileVersion;

pub const ListFileCommitHistoryInput = struct {
    /// The fully quaified reference that identifies the commit that contains the
    /// file. For
    /// example, you can specify a full commit ID, a tag, a branch name, or a
    /// reference such as
    /// `refs/heads/main`. If none is provided, the head commit is used.
    commit_specifier: ?[]const u8 = null,

    /// The full path of the file whose history you want to retrieve, including the
    /// name of the file.
    file_path: []const u8,

    /// A non-zero, non-negative integer used to limit the number of returned
    /// results.
    max_results: ?i32 = null,

    /// An enumeration token that allows the operation to batch the results.
    next_token: ?[]const u8 = null,

    /// The name of the repository that contains the file.
    repository_name: []const u8,

    pub const json_field_names = .{
        .commit_specifier = "commitSpecifier",
        .file_path = "filePath",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .repository_name = "repositoryName",
    };
};

pub const ListFileCommitHistoryOutput = struct {
    /// An enumeration token that can be used to return the next batch of results.
    next_token: ?[]const u8 = null,

    /// An array of FileVersion objects that form a directed acyclic graph (DAG) of
    /// the changes to the file made by the commits that changed the file.
    revision_dag: ?[]const FileVersion = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .revision_dag = "revisionDag",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFileCommitHistoryInput, options: CallOptions) !ListFileCommitHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFileCommitHistoryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.ListFileCommitHistory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFileCommitHistoryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListFileCommitHistoryOutput, body, allocator);
}
