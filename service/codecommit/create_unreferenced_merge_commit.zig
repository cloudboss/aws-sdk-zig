const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConflictDetailLevelTypeEnum = @import("conflict_detail_level_type_enum.zig").ConflictDetailLevelTypeEnum;
const ConflictResolution = @import("conflict_resolution.zig").ConflictResolution;
const ConflictResolutionStrategyTypeEnum = @import("conflict_resolution_strategy_type_enum.zig").ConflictResolutionStrategyTypeEnum;
const MergeOptionTypeEnum = @import("merge_option_type_enum.zig").MergeOptionTypeEnum;

pub const CreateUnreferencedMergeCommitInput = struct {
    /// The name of the author who created the unreferenced commit. This information
    /// is used
    /// as both the author and committer for the commit.
    author_name: ?[]const u8 = null,

    /// The commit message for the unreferenced commit.
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

    /// The branch, tag, HEAD, or other fully qualified reference used to identify a
    /// commit
    /// (for example, a branch name or a full commit ID).
    destination_commit_specifier: []const u8,

    /// The email address for the person who created the unreferenced commit.
    email: ?[]const u8 = null,

    /// If the commit contains deletions, whether to keep a folder or folder
    /// structure if the
    /// changes leave the folders empty. If this is specified as true, a .gitkeep
    /// file is
    /// created for empty folders. The default is false.
    keep_empty_folders: ?bool = null,

    /// The merge option or strategy you want to use to merge the code.
    merge_option: MergeOptionTypeEnum,

    /// The name of the repository where you want to create the unreferenced merge
    /// commit.
    repository_name: []const u8,

    /// The branch, tag, HEAD, or other fully qualified reference used to identify a
    /// commit
    /// (for example, a branch name or a full commit ID).
    source_commit_specifier: []const u8,

    pub const json_field_names = .{
        .author_name = "authorName",
        .commit_message = "commitMessage",
        .conflict_detail_level = "conflictDetailLevel",
        .conflict_resolution = "conflictResolution",
        .conflict_resolution_strategy = "conflictResolutionStrategy",
        .destination_commit_specifier = "destinationCommitSpecifier",
        .email = "email",
        .keep_empty_folders = "keepEmptyFolders",
        .merge_option = "mergeOption",
        .repository_name = "repositoryName",
        .source_commit_specifier = "sourceCommitSpecifier",
    };
};

pub const CreateUnreferencedMergeCommitOutput = struct {
    /// The full commit ID of the commit that contains your merge results.
    commit_id: ?[]const u8 = null,

    /// The full SHA-1 pointer of the tree information for the commit that contains
    /// the merge results.
    tree_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .commit_id = "commitId",
        .tree_id = "treeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUnreferencedMergeCommitInput, options: CallOptions) !CreateUnreferencedMergeCommitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUnreferencedMergeCommitInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.CreateUnreferencedMergeCommit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUnreferencedMergeCommitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateUnreferencedMergeCommitOutput, body, allocator);
}
