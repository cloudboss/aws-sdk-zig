const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConflictDetailLevelTypeEnum = @import("conflict_detail_level_type_enum.zig").ConflictDetailLevelTypeEnum;
const ConflictResolutionStrategyTypeEnum = @import("conflict_resolution_strategy_type_enum.zig").ConflictResolutionStrategyTypeEnum;
const MergeOptionTypeEnum = @import("merge_option_type_enum.zig").MergeOptionTypeEnum;
const Conflict = @import("conflict.zig").Conflict;
const BatchDescribeMergeConflictsError = @import("batch_describe_merge_conflicts_error.zig").BatchDescribeMergeConflictsError;

pub const BatchDescribeMergeConflictsInput = struct {
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

    /// The path of the target files used to describe the conflicts. If not
    /// specified, the default is all conflict files.
    file_paths: ?[]const []const u8 = null,

    /// The maximum number of files to include in the output.
    max_conflict_files: ?i32 = null,

    /// The maximum number of merge hunks to include in the output.
    max_merge_hunks: ?i32 = null,

    /// The merge option or strategy you want to use to merge the code.
    merge_option: MergeOptionTypeEnum,

    /// An enumeration token that, when provided in a request, returns the next
    /// batch of the
    /// results.
    next_token: ?[]const u8 = null,

    /// The name of the repository that contains the merge conflicts you want to
    /// review.
    repository_name: []const u8,

    /// The branch, tag, HEAD, or other fully qualified reference used to identify a
    /// commit
    /// (for example, a branch name or a full commit ID).
    source_commit_specifier: []const u8,

    pub const json_field_names = .{
        .conflict_detail_level = "conflictDetailLevel",
        .conflict_resolution_strategy = "conflictResolutionStrategy",
        .destination_commit_specifier = "destinationCommitSpecifier",
        .file_paths = "filePaths",
        .max_conflict_files = "maxConflictFiles",
        .max_merge_hunks = "maxMergeHunks",
        .merge_option = "mergeOption",
        .next_token = "nextToken",
        .repository_name = "repositoryName",
        .source_commit_specifier = "sourceCommitSpecifier",
    };
};

pub const BatchDescribeMergeConflictsOutput = struct {
    /// The commit ID of the merge base.
    base_commit_id: ?[]const u8 = null,

    /// A list of conflicts for each file, including the conflict metadata and the
    /// hunks of the differences between the files.
    conflicts: ?[]const Conflict = null,

    /// The commit ID of the destination commit specifier that was used in the merge
    /// evaluation.
    destination_commit_id: []const u8,

    /// A list of any errors returned while describing the merge conflicts for each
    /// file.
    errors: ?[]const BatchDescribeMergeConflictsError = null,

    /// An enumeration token that can be used in a request to return the next batch
    /// of the results.
    next_token: ?[]const u8 = null,

    /// The commit ID of the source commit specifier that was used in the merge
    /// evaluation.
    source_commit_id: []const u8,

    pub const json_field_names = .{
        .base_commit_id = "baseCommitId",
        .conflicts = "conflicts",
        .destination_commit_id = "destinationCommitId",
        .errors = "errors",
        .next_token = "nextToken",
        .source_commit_id = "sourceCommitId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDescribeMergeConflictsInput, options: CallOptions) !BatchDescribeMergeConflictsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDescribeMergeConflictsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.BatchDescribeMergeConflicts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDescribeMergeConflictsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(BatchDescribeMergeConflictsOutput, body, allocator);
}
