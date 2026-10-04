const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const MergeBranchesByFastForwardInput = struct {
    /// The branch, tag, HEAD, or other fully qualified reference used to identify a
    /// commit
    /// (for example, a branch name or a full commit ID).
    destination_commit_specifier: []const u8,

    /// The name of the repository where you want to merge two branches.
    repository_name: []const u8,

    /// The branch, tag, HEAD, or other fully qualified reference used to identify a
    /// commit
    /// (for example, a branch name or a full commit ID).
    source_commit_specifier: []const u8,

    /// The branch where the merge is applied.
    target_branch: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_commit_specifier = "destinationCommitSpecifier",
        .repository_name = "repositoryName",
        .source_commit_specifier = "sourceCommitSpecifier",
        .target_branch = "targetBranch",
    };
};

pub const MergeBranchesByFastForwardOutput = struct {
    /// The commit ID of the merge in the destination or target branch.
    commit_id: ?[]const u8 = null,

    /// The tree ID of the merge in the destination or target branch.
    tree_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .commit_id = "commitId",
        .tree_id = "treeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: MergeBranchesByFastForwardInput, options: CallOptions) !MergeBranchesByFastForwardOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: MergeBranchesByFastForwardInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.MergeBranchesByFastForward");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !MergeBranchesByFastForwardOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(MergeBranchesByFastForwardOutput, body, allocator);
}
