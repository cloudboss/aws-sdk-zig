const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConflictDetailLevelTypeEnum = @import("conflict_detail_level_type_enum.zig").ConflictDetailLevelTypeEnum;
const ConflictResolution = @import("conflict_resolution.zig").ConflictResolution;
const ConflictResolutionStrategyTypeEnum = @import("conflict_resolution_strategy_type_enum.zig").ConflictResolutionStrategyTypeEnum;
const PullRequest = @import("pull_request.zig").PullRequest;

pub const MergePullRequestBySquashInput = struct {
    /// The name of the author who created the commit. This information is used as
    /// both the
    /// author and committer for the commit.
    author_name: ?[]const u8 = null,

    /// The commit message to include in the commit information for the merge.
    commit_message: ?[]const u8 = null,

    /// The level of conflict detail to use. If unspecified, the default FILE_LEVEL
    /// is used,
    /// which returns a not-mergeable result if the same file has differences in
    /// both branches.
    /// If LINE_LEVEL is specified, a conflict is considered not mergeable if the
    /// same file in
    /// both branches has differences on the same line.
    conflict_detail_level: ?ConflictDetailLevelTypeEnum = null,

    /// If AUTOMERGE is the conflict resolution strategy, a list of inputs to use
    /// when
    /// resolving conflicts during a merge.
    conflict_resolution: ?ConflictResolution = null,

    /// Specifies which branch to use when resolving conflicts, or whether to
    /// attempt
    /// automatically merging two versions of a file. The default is NONE, which
    /// requires any
    /// conflicts to be resolved manually before the merge operation is successful.
    conflict_resolution_strategy: ?ConflictResolutionStrategyTypeEnum = null,

    /// The email address of the person merging the branches. This information is
    /// used in the
    /// commit information for the merge.
    email: ?[]const u8 = null,

    /// If the commit contains deletions, whether to keep a folder or folder
    /// structure if the
    /// changes leave the folders empty. If true, a .gitkeep file is created for
    /// empty folders.
    /// The default is false.
    keep_empty_folders: ?bool = null,

    /// The system-generated ID of the pull request. To get this ID, use
    /// ListPullRequests.
    pull_request_id: []const u8,

    /// The name of the repository where the pull request was created.
    repository_name: []const u8,

    /// The full commit ID of the original or updated commit in the pull request
    /// source branch. Pass this value if you want an
    /// exception thrown if the current commit ID of the tip of the source branch
    /// does not match this commit ID.
    source_commit_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .author_name = "authorName",
        .commit_message = "commitMessage",
        .conflict_detail_level = "conflictDetailLevel",
        .conflict_resolution = "conflictResolution",
        .conflict_resolution_strategy = "conflictResolutionStrategy",
        .email = "email",
        .keep_empty_folders = "keepEmptyFolders",
        .pull_request_id = "pullRequestId",
        .repository_name = "repositoryName",
        .source_commit_id = "sourceCommitId",
    };
};

pub const MergePullRequestBySquashOutput = struct {
    pull_request: ?PullRequest = null,

    pub const json_field_names = .{
        .pull_request = "pullRequest",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: MergePullRequestBySquashInput, options: CallOptions) !MergePullRequestBySquashOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: MergePullRequestBySquashInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.MergePullRequestBySquash");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !MergePullRequestBySquashOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(MergePullRequestBySquashOutput, body, allocator);
}
