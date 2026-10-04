const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3DataRepositoryConfiguration = @import("s3_data_repository_configuration.zig").S3DataRepositoryConfiguration;
const Tag = @import("tag.zig").Tag;
const DataRepositoryAssociation = @import("data_repository_association.zig").DataRepositoryAssociation;

pub const CreateDataRepositoryAssociationInput = struct {
    /// Set to `true` to run an import data repository task to import
    /// metadata from the data repository to the file system after the data
    /// repository
    /// association is created. Default is `false`.
    batch_import_meta_data_on_create: ?bool = null,

    client_request_token: ?[]const u8 = null,

    /// The path to the Amazon S3 data repository that will be linked to the file
    /// system. The path can be an S3 bucket or prefix in the format
    /// `s3://bucket-name/prefix/` (where `prefix`
    /// is optional). This path specifies where in the S3 data repository
    /// files will be imported from or exported to.
    data_repository_path: []const u8,

    file_system_id: []const u8,

    /// A path on the file system that points to a high-level directory (such
    /// as `/ns1/`) or subdirectory (such as `/ns1/subdir/`)
    /// that will be mapped 1-1 with `DataRepositoryPath`.
    /// The leading forward slash in the name is required. Two data repository
    /// associations cannot have overlapping file system paths. For example, if
    /// a data repository is associated with file system path `/ns1/`,
    /// then you cannot link another data repository with file system
    /// path `/ns1/ns2`.
    ///
    /// This path specifies where in your file system files will be exported
    /// from or imported to. This file system directory can be linked to only one
    /// Amazon S3 bucket, and no other S3 bucket can be linked to the directory.
    ///
    /// If you specify only a forward slash (`/`) as the file system
    /// path, you can link only one data repository to the file system. You can only
    /// specify
    /// "/" as the file system path for the first data repository associated with a
    /// file system.
    file_system_path: ?[]const u8 = null,

    /// For files imported from a data repository, this value determines the stripe
    /// count and
    /// maximum amount of data per file (in MiB) stored on a single physical disk.
    /// The maximum
    /// number of disks that a single file can be striped across is limited by the
    /// total number
    /// of disks that make up the file system.
    ///
    /// The default chunk size is 1,024 MiB (1 GiB) and can go as high as 512,000
    /// MiB (500
    /// GiB). Amazon S3 objects have a maximum size of 5 TB.
    imported_file_chunk_size: ?i32 = null,

    /// The configuration for an Amazon S3 data repository linked to an
    /// Amazon FSx Lustre file system with a data repository association.
    /// The configuration defines which file events (new, changed, or
    /// deleted files or directories) are automatically imported from
    /// the linked data repository to the file system or automatically
    /// exported from the file system to the data repository.
    s3: ?S3DataRepositoryConfiguration = null,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .batch_import_meta_data_on_create = "BatchImportMetaDataOnCreate",
        .client_request_token = "ClientRequestToken",
        .data_repository_path = "DataRepositoryPath",
        .file_system_id = "FileSystemId",
        .file_system_path = "FileSystemPath",
        .imported_file_chunk_size = "ImportedFileChunkSize",
        .s3 = "S3",
        .tags = "Tags",
    };
};

pub const CreateDataRepositoryAssociationOutput = struct {
    /// The response object returned after the data repository association is
    /// created.
    association: ?DataRepositoryAssociation = null,

    pub const json_field_names = .{
        .association = "Association",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataRepositoryAssociationInput, options: CallOptions) !CreateDataRepositoryAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataRepositoryAssociationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateDataRepositoryAssociation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataRepositoryAssociationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDataRepositoryAssociationOutput, body, allocator);
}
