const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConflictDetailLevelTypeEnum = @import("conflict_detail_level_type_enum.zig").ConflictDetailLevelTypeEnum;
const ConflictResolutionStrategyTypeEnum = @import("conflict_resolution_strategy_type_enum.zig").ConflictResolutionStrategyTypeEnum;

pub const GetMergeCommitInput = struct {
    /// The level of conflict detail to use. If unspecified, the default FILE_LEVEL
    /// is used,
    /// which returns a not-mergeable result if the same file has differences in
    /// both branches.
    /// If LINE_LEVEL is specified, a conflict is considered not mergeable if the
    /// same file in
    /// both branches has differences on the same line.
    conflict_detail_level: ?ConflictDetailLevelTypeEnum = null,

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

    /// The name of the repository that contains the merge commit about which you
    /// want to get information.
    repository_name: []const u8,

    /// The branch, tag, HEAD, or other fully qualified reference used to identify a
    /// commit
    /// (for example, a branch name or a full commit ID).
    source_commit_specifier: []const u8,

    pub const json_field_names = .{
        .conflict_detail_level = "conflictDetailLevel",
        .conflict_resolution_strategy = "conflictResolutionStrategy",
        .destination_commit_specifier = "destinationCommitSpecifier",
        .repository_name = "repositoryName",
        .source_commit_specifier = "sourceCommitSpecifier",
    };
};

pub const GetMergeCommitOutput = struct {
    /// The commit ID of the merge base.
    base_commit_id: ?[]const u8 = null,

    /// The commit ID of the destination commit specifier that was used in the merge
    /// evaluation.
    destination_commit_id: ?[]const u8 = null,

    /// The commit ID for the merge commit created when the source branch was merged
    /// into the
    /// destination branch. If the fast-forward merge strategy was used, there is no
    /// merge
    /// commit.
    merged_commit_id: ?[]const u8 = null,

    /// The commit ID of the source commit specifier that was used in the merge
    /// evaluation.
    source_commit_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_commit_id = "baseCommitId",
        .destination_commit_id = "destinationCommitId",
        .merged_commit_id = "mergedCommitId",
        .source_commit_id = "sourceCommitId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMergeCommitInput, options: CallOptions) !GetMergeCommitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMergeCommitInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.GetMergeCommit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMergeCommitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMergeCommitOutput, body, allocator);
}
