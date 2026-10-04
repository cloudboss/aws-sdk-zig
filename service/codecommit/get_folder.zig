const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const File = @import("file.zig").File;
const Folder = @import("folder.zig").Folder;
const SubModule = @import("sub_module.zig").SubModule;
const SymbolicLink = @import("symbolic_link.zig").SymbolicLink;

pub const GetFolderInput = struct {
    /// A fully qualified reference used to identify a commit that contains the
    /// version of the
    /// folder's content to return. A fully qualified reference can be a commit ID,
    /// branch name,
    /// tag, or reference such as HEAD. If no specifier is provided, the folder
    /// content is
    /// returned as it exists in the HEAD commit.
    commit_specifier: ?[]const u8 = null,

    /// The fully qualified path to the folder whose contents are returned,
    /// including the
    /// folder name. For example, /examples is a fully-qualified path to a folder
    /// named examples
    /// that was created off of the root directory (/) of a repository.
    folder_path: []const u8,

    /// The name of the repository.
    repository_name: []const u8,

    pub const json_field_names = .{
        .commit_specifier = "commitSpecifier",
        .folder_path = "folderPath",
        .repository_name = "repositoryName",
    };
};

pub const GetFolderOutput = struct {
    /// The full commit ID used as a reference for the returned version of the
    /// folder
    /// content.
    commit_id: []const u8,

    /// The list of files in the specified folder, if any.
    files: ?[]const File = null,

    /// The fully qualified path of the folder whose contents are returned.
    folder_path: []const u8,

    /// The list of folders that exist under the specified folder, if any.
    sub_folders: ?[]const Folder = null,

    /// The list of submodules in the specified folder, if any.
    sub_modules: ?[]const SubModule = null,

    /// The list of symbolic links to other files and folders in the specified
    /// folder, if
    /// any.
    symbolic_links: ?[]const SymbolicLink = null,

    /// The full SHA-1 pointer of the tree information for the commit that contains
    /// the folder.
    tree_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .commit_id = "commitId",
        .files = "files",
        .folder_path = "folderPath",
        .sub_folders = "subFolders",
        .sub_modules = "subModules",
        .symbolic_links = "symbolicLinks",
        .tree_id = "treeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFolderInput, options: CallOptions) !GetFolderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFolderInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.GetFolder");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFolderOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetFolderOutput, body, allocator);
}
