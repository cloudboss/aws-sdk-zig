const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeleteFileEntry = @import("delete_file_entry.zig").DeleteFileEntry;
const PutFileEntry = @import("put_file_entry.zig").PutFileEntry;
const SetFileModeEntry = @import("set_file_mode_entry.zig").SetFileModeEntry;
const FileMetadata = @import("file_metadata.zig").FileMetadata;

pub const CreateCommitInput = struct {
    /// The name of the author who created the commit. This information is used as
    /// both the
    /// author and committer for the commit.
    author_name: ?[]const u8 = null,

    /// The name of the branch where you create the commit.
    branch_name: []const u8,

    /// The commit message you want to include in the commit. Commit messages are
    /// limited to
    /// 256 KB. If no message is specified, a default message is used.
    commit_message: ?[]const u8 = null,

    /// The files to delete in this commit. These files still exist in earlier
    /// commits.
    delete_files: ?[]const DeleteFileEntry = null,

    /// The email address of the person who created the commit.
    email: ?[]const u8 = null,

    /// If the commit contains deletions, whether to keep a folder or folder
    /// structure if the
    /// changes leave the folders empty. If true, a ..gitkeep file is created for
    /// empty folders.
    /// The default is false.
    keep_empty_folders: ?bool = null,

    /// The ID of the commit that is the parent of the commit you create. Not
    /// required if this
    /// is an empty repository.
    parent_commit_id: ?[]const u8 = null,

    /// The files to add or update in this commit.
    put_files: ?[]const PutFileEntry = null,

    /// The name of the repository where you create the commit.
    repository_name: []const u8,

    /// The file modes to update for files in this commit.
    set_file_modes: ?[]const SetFileModeEntry = null,

    pub const json_field_names = .{
        .author_name = "authorName",
        .branch_name = "branchName",
        .commit_message = "commitMessage",
        .delete_files = "deleteFiles",
        .email = "email",
        .keep_empty_folders = "keepEmptyFolders",
        .parent_commit_id = "parentCommitId",
        .put_files = "putFiles",
        .repository_name = "repositoryName",
        .set_file_modes = "setFileModes",
    };
};

pub const CreateCommitOutput = struct {
    /// The full commit ID of the commit that contains your committed file changes.
    commit_id: ?[]const u8 = null,

    /// The files added as part of the committed file changes.
    files_added: ?[]const FileMetadata = null,

    /// The files deleted as part of the committed file changes.
    files_deleted: ?[]const FileMetadata = null,

    /// The files updated as part of the commited file changes.
    files_updated: ?[]const FileMetadata = null,

    /// The full SHA-1 pointer of the tree information for the commit that contains
    /// the commited file changes.
    tree_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .commit_id = "commitId",
        .files_added = "filesAdded",
        .files_deleted = "filesDeleted",
        .files_updated = "filesUpdated",
        .tree_id = "treeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCommitInput, options: CallOptions) !CreateCommitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCommitInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.CreateCommit");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCommitOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCommitOutput, body, allocator);
}
