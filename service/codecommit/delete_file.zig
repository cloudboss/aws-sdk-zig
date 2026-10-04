const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteFileInput = struct {
    /// The name of the branch where the commit that deletes the file is made.
    branch_name: []const u8,

    /// The commit message you want to include as part of deleting the file. Commit
    /// messages
    /// are limited to 256 KB. If no message is specified, a default message is
    /// used.
    commit_message: ?[]const u8 = null,

    /// The email address for the commit that deletes the file. If no email address
    /// is
    /// specified, the email address is left blank.
    email: ?[]const u8 = null,

    /// The fully qualified path to the file that to be deleted, including the full
    /// name and
    /// extension of that file. For example, /examples/file.md is a fully qualified
    /// path to a
    /// file named file.md in a folder named examples.
    file_path: []const u8,

    /// If a file is the only object in the folder or directory, specifies whether
    /// to delete
    /// the folder or directory that contains the file. By default, empty folders
    /// are deleted.
    /// This includes empty folders that are part of the directory structure. For
    /// example, if
    /// the path to a file is dir1/dir2/dir3/dir4, and dir2 and dir3 are empty,
    /// deleting the
    /// last file in dir4 also deletes the empty folders dir4, dir3, and dir2.
    keep_empty_folders: ?bool = null,

    /// The name of the author of the commit that deletes the file. If no name is
    /// specified,
    /// the user's ARN is used as the author name and committer name.
    name: ?[]const u8 = null,

    /// The ID of the commit that is the tip of the branch where you want to create
    /// the commit
    /// that deletes the file. This must be the HEAD commit for the branch. The
    /// commit that
    /// deletes the file is created from this commit ID.
    parent_commit_id: []const u8,

    /// The name of the repository that contains the file to delete.
    repository_name: []const u8,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .commit_message = "commitMessage",
        .email = "email",
        .file_path = "filePath",
        .keep_empty_folders = "keepEmptyFolders",
        .name = "name",
        .parent_commit_id = "parentCommitId",
        .repository_name = "repositoryName",
    };
};

pub const DeleteFileOutput = struct {
    /// The blob ID removed from the tree as part of deleting the file.
    blob_id: []const u8,

    /// The full commit ID of the commit that contains the change that deletes the
    /// file.
    commit_id: []const u8,

    /// The fully qualified path to the file to be deleted, including the full name
    /// and
    /// extension of that file.
    file_path: []const u8,

    /// The full SHA-1 pointer of the tree information for the commit that contains
    /// the delete file change.
    tree_id: []const u8,

    pub const json_field_names = .{
        .blob_id = "blobId",
        .commit_id = "commitId",
        .file_path = "filePath",
        .tree_id = "treeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFileInput, options: CallOptions) !DeleteFileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFileInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.DeleteFile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFileOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteFileOutput, body, allocator);
}
