const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReleaseConfiguration = @import("release_configuration.zig").ReleaseConfiguration;
const CompletionReport = @import("completion_report.zig").CompletionReport;
const Tag = @import("tag.zig").Tag;
const DataRepositoryTaskType = @import("data_repository_task_type.zig").DataRepositoryTaskType;
const DataRepositoryTask = @import("data_repository_task.zig").DataRepositoryTask;

pub const CreateDataRepositoryTaskInput = struct {
    /// Specifies the amount of data to release, in GiB, by an Amazon File Cache
    /// `AUTO_RELEASE_DATA` task that automatically releases files from the cache.
    capacity_to_release: ?i64 = null,

    client_request_token: ?[]const u8 = null,

    file_system_id: []const u8,

    /// A list of paths for the data repository task to use when the task is
    /// processed.
    /// If a path that you provide isn't valid, the task fails. If you don't provide
    /// paths, the default behavior is to export all files to S3 (for export tasks),
    /// import
    /// all files from S3 (for import tasks), or release all exported files that
    /// meet the
    /// last accessed time criteria (for release tasks).
    ///
    /// * For export tasks, the list contains paths on the FSx for Lustre file
    ///   system
    /// from which the files are exported to the Amazon S3 bucket. The default path
    /// is the
    /// file system root directory. The paths you provide need to be relative to the
    /// mount
    /// point of the file system. If the mount point is `/mnt/fsx` and
    /// `/mnt/fsx/path1` is a directory or file on the file system you want
    /// to export, then the path to provide is `path1`.
    ///
    /// * For import tasks, the list contains paths in the Amazon S3 bucket
    /// from which POSIX metadata changes are imported to the FSx for Lustre file
    /// system.
    /// The path can be an S3 bucket or prefix in the format
    /// `s3://bucket-name/prefix` (where `prefix` is optional).
    ///
    /// * For release tasks, the list contains directory or file paths on the
    /// FSx for Lustre file system from which to release exported files. If a
    /// directory is
    /// specified, files within the directory are released. If a file path is
    /// specified,
    /// only that file is released. To release all exported files in the file
    /// system,
    /// specify a forward slash (/) as the path.
    ///
    /// A file must also meet the last accessed time criteria
    /// specified in for the
    /// file to be released.
    paths: ?[]const []const u8 = null,

    /// The configuration that specifies the last accessed time criteria for files
    /// that will be released from an Amazon FSx for Lustre file system.
    release_configuration: ?ReleaseConfiguration = null,

    /// Defines whether or not Amazon FSx provides a CompletionReport once the task
    /// has completed.
    /// A CompletionReport provides a detailed report on the files that Amazon FSx
    /// processed that meet the criteria specified by the
    /// `Scope` parameter. For more information, see
    /// [Working with Task Completion
    /// Reports](https://docs.aws.amazon.com/fsx/latest/LustreGuide/task-completion-report.html).
    report: CompletionReport,

    tags: ?[]const Tag = null,

    /// Specifies the type of data repository task to create.
    ///
    /// * `EXPORT_TO_REPOSITORY` tasks export from your
    /// Amazon FSx for Lustre file system to a linked data repository.
    ///
    /// * `IMPORT_METADATA_FROM_REPOSITORY` tasks import metadata
    /// changes from a linked S3 bucket to your Amazon FSx for Lustre file system.
    ///
    /// * `RELEASE_DATA_FROM_FILESYSTEM` tasks release files in
    /// your Amazon FSx for Lustre file system that have been exported to a linked
    /// S3 bucket and that meet your specified release criteria.
    ///
    /// * `AUTO_RELEASE_DATA` tasks automatically release files from
    /// an Amazon File Cache resource.
    type: DataRepositoryTaskType,

    pub const json_field_names = .{
        .capacity_to_release = "CapacityToRelease",
        .client_request_token = "ClientRequestToken",
        .file_system_id = "FileSystemId",
        .paths = "Paths",
        .release_configuration = "ReleaseConfiguration",
        .report = "Report",
        .tags = "Tags",
        .type = "Type",
    };
};

pub const CreateDataRepositoryTaskOutput = struct {
    /// The description of the data repository task that you just created.
    data_repository_task: ?DataRepositoryTask = null,

    pub const json_field_names = .{
        .data_repository_task = "DataRepositoryTask",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataRepositoryTaskInput, options: CallOptions) !CreateDataRepositoryTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataRepositoryTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateDataRepositoryTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataRepositoryTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDataRepositoryTaskOutput, body, allocator);
}
