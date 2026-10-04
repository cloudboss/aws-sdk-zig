const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConflictDetailLevelTypeEnum = @import("conflict_detail_level_type_enum.zig").ConflictDetailLevelTypeEnum;
const ConflictResolutionStrategyTypeEnum = @import("conflict_resolution_strategy_type_enum.zig").ConflictResolutionStrategyTypeEnum;
const MergeOptionTypeEnum = @import("merge_option_type_enum.zig").MergeOptionTypeEnum;
const ConflictMetadata = @import("conflict_metadata.zig").ConflictMetadata;

pub const GetMergeConflictsInput = struct {
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

    /// The maximum number of files to include in the output.
    max_conflict_files: ?i32 = null,

    /// The merge option or strategy you want to use to merge the code.
    merge_option: MergeOptionTypeEnum,

    /// An enumeration token that, when provided in a request, returns the next
    /// batch of the
    /// results.
    next_token: ?[]const u8 = null,

    /// The name of the repository where the pull request was created.
    repository_name: []const u8,

    /// The branch, tag, HEAD, or other fully qualified reference used to identify a
    /// commit
    /// (for example, a branch name or a full commit ID).
    source_commit_specifier: []const u8,

    pub const json_field_names = .{
        .conflict_detail_level = "conflictDetailLevel",
        .conflict_resolution_strategy = "conflictResolutionStrategy",
        .destination_commit_specifier = "destinationCommitSpecifier",
        .max_conflict_files = "maxConflictFiles",
        .merge_option = "mergeOption",
        .next_token = "nextToken",
        .repository_name = "repositoryName",
        .source_commit_specifier = "sourceCommitSpecifier",
    };
};

pub const GetMergeConflictsOutput = struct {
    /// The commit ID of the merge base.
    base_commit_id: ?[]const u8 = null,

    /// A list of metadata for any conflicting files. If the specified merge
    /// strategy is
    /// FAST_FORWARD_MERGE, this list is always empty.
    conflict_metadata_list: ?[]const ConflictMetadata = null,

    /// The commit ID of the destination commit specifier that was used in the merge
    /// evaluation.
    destination_commit_id: []const u8,

    /// A Boolean value that indicates whether the code is mergeable by the
    /// specified merge option.
    mergeable: ?bool = null,

    /// An enumeration token that can be used in a request to return the next batch
    /// of the results.
    next_token: ?[]const u8 = null,

    /// The commit ID of the source commit specifier that was used in the merge
    /// evaluation.
    source_commit_id: []const u8,

    pub const json_field_names = .{
        .base_commit_id = "baseCommitId",
        .conflict_metadata_list = "conflictMetadataList",
        .destination_commit_id = "destinationCommitId",
        .mergeable = "mergeable",
        .next_token = "nextToken",
        .source_commit_id = "sourceCommitId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMergeConflictsInput, options: CallOptions) !GetMergeConflictsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMergeConflictsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.GetMergeConflicts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMergeConflictsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetMergeConflictsOutput, body, allocator);
}
