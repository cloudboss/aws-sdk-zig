const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileModeTypeEnum = @import("file_mode_type_enum.zig").FileModeTypeEnum;

pub const PutFileInput = struct {
    /// The name of the branch where you want to add or update the file. If this is
    /// an empty
    /// repository, this branch is created.
    branch_name: []const u8,

    /// A message about why this file was added or updated. Although it is optional,
    /// a message
    /// makes the commit history for your repository more useful.
    commit_message: ?[]const u8 = null,

    /// An email address for the person adding or updating the file.
    email: ?[]const u8 = null,

    /// The content of the file, in binary object format.
    file_content: []const u8,

    /// The file mode permissions of the blob. Valid file mode permissions are
    /// listed
    /// here.
    file_mode: ?FileModeTypeEnum = null,

    /// The name of the file you want to add or update, including the relative path
    /// to the file in the repository.
    ///
    /// If the path does not currently exist in the repository, the path is created
    /// as part of adding
    /// the file.
    file_path: []const u8,

    /// The name of the person adding or updating the file. Although it is optional,
    /// a name
    /// makes the commit history for your repository more useful.
    name: ?[]const u8 = null,

    /// The full commit ID of the head commit in the branch where you want to add or
    /// update the file. If this is an empty repository,
    /// no commit ID is required. If this is not an empty repository, a commit ID is
    /// required.
    ///
    /// The commit ID must match the ID of the head commit at the time of the
    /// operation.
    /// Otherwise, an error occurs, and the file is not added or updated.
    parent_commit_id: ?[]const u8 = null,

    /// The name of the repository where you want to add or update the file.
    repository_name: []const u8,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .commit_message = "commitMessage",
        .email = "email",
        .file_content = "fileContent",
        .file_mode = "fileMode",
        .file_path = "filePath",
        .name = "name",
        .parent_commit_id = "parentCommitId",
        .repository_name = "repositoryName",
    };
};

pub const PutFileOutput = struct {
    /// The ID of the blob, which is its SHA-1 pointer.
    blob_id: []const u8,

    /// The full SHA ID of the commit that contains this file change.
    commit_id: []const u8,

    /// The full SHA-1 pointer of the tree information for the commit that contains
    /// this file change.
    tree_id: []const u8,

    pub const json_field_names = .{
        .blob_id = "blobId",
        .commit_id = "commitId",
        .tree_id = "treeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutFileInput, options: CallOptions) !PutFileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutFileInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.PutFile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutFileOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PutFileOutput, body, allocator);
}
