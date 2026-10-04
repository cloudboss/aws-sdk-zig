const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileModeTypeEnum = @import("file_mode_type_enum.zig").FileModeTypeEnum;

pub const GetFileInput = struct {
    /// The fully quaified reference that identifies the commit that contains the
    /// file. For
    /// example, you can specify a full commit ID, a tag, a branch name, or a
    /// reference such as
    /// refs/heads/main. If none is provided, the head commit is used.
    commit_specifier: ?[]const u8 = null,

    /// The fully qualified path to the file, including the full name and extension
    /// of the
    /// file. For example, /examples/file.md is the fully qualified path to a file
    /// named file.md
    /// in a folder named examples.
    file_path: []const u8,

    /// The name of the repository that contains the file.
    repository_name: []const u8,

    pub const json_field_names = .{
        .commit_specifier = "commitSpecifier",
        .file_path = "filePath",
        .repository_name = "repositoryName",
    };
};

pub const GetFileOutput = struct {
    /// The blob ID of the object that represents the file content.
    blob_id: []const u8,

    /// The full commit ID of the commit that contains the content returned by
    /// GetFile.
    commit_id: []const u8,

    /// The base-64 encoded binary data object that represents the content of the
    /// file.
    file_content: []const u8,

    /// The extrapolated file mode permissions of the blob. Valid values include
    /// strings such as EXECUTABLE and not numeric values.
    ///
    /// The file mode permissions returned by this API are not the standard file
    /// mode
    /// permission values, such as 100644, but rather extrapolated values. See the
    /// supported
    /// return values.
    file_mode: FileModeTypeEnum,

    /// The fully qualified path to the specified file. Returns the name and
    /// extension of the
    /// file.
    file_path: []const u8,

    /// The size of the contents of the file, in bytes.
    file_size: ?i64 = null,

    pub const json_field_names = .{
        .blob_id = "blobId",
        .commit_id = "commitId",
        .file_content = "fileContent",
        .file_mode = "fileMode",
        .file_path = "filePath",
        .file_size = "fileSize",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFileInput, options: CallOptions) !GetFileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFileInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.GetFile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFileOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetFileOutput, body, allocator);
}
