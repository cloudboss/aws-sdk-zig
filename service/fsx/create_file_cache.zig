const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileCacheDataRepositoryAssociation = @import("file_cache_data_repository_association.zig").FileCacheDataRepositoryAssociation;
const FileCacheType = @import("file_cache_type.zig").FileCacheType;
const CreateFileCacheLustreConfiguration = @import("create_file_cache_lustre_configuration.zig").CreateFileCacheLustreConfiguration;
const Tag = @import("tag.zig").Tag;
const FileCacheCreating = @import("file_cache_creating.zig").FileCacheCreating;

pub const CreateFileCacheInput = struct {
    /// An idempotency token for resource creation, in a string of up to 63
    /// ASCII characters. This token is automatically filled on your behalf when you
    /// use the
    /// Command Line Interface (CLI) or an Amazon Web Services SDK.
    ///
    /// By using the idempotent operation, you can retry a `CreateFileCache`
    /// operation without the risk of creating an extra cache. This approach can be
    /// useful
    /// when an initial call fails in a way that makes it unclear whether a cache
    /// was created.
    /// Examples are if a transport level timeout occurred, or your connection was
    /// reset.
    /// If you use the same client request token and the initial call created a
    /// cache, the
    /// client receives success as long as the parameters are the same.
    client_request_token: ?[]const u8 = null,

    /// A boolean flag indicating whether tags for the cache should be copied to
    /// data repository associations. This value defaults to false.
    copy_tags_to_data_repository_associations: ?bool = null,

    /// A list of up to 8 configurations for data repository associations (DRAs) to
    /// be created during the cache creation. The DRAs link the cache to either an
    /// Amazon S3 data repository or a Network File System (NFS) data repository
    /// that supports the NFSv3 protocol.
    ///
    /// The DRA configurations must meet the following requirements:
    ///
    /// * All configurations on the list must be of the
    /// same data repository type, either all S3 or all NFS. A cache
    /// can't link to different data repository types at the same time.
    ///
    /// * An NFS DRA must link to an NFS file system that
    /// supports the NFSv3 protocol.
    ///
    /// DRA automatic import and automatic export is not supported.
    data_repository_associations: ?[]const FileCacheDataRepositoryAssociation = null,

    /// The type of cache that you're creating, which
    /// must be `LUSTRE`.
    file_cache_type: FileCacheType,

    /// Sets the Lustre version for the cache that you're creating,
    /// which must be `2.12`.
    file_cache_type_version: []const u8,

    /// Specifies the ID of the Key Management Service (KMS) key to use for
    /// encrypting data on
    /// an Amazon File Cache. If a `KmsKeyId` isn't specified, the Amazon
    /// FSx-managed
    /// KMS key for your account is used. For more information,
    /// see
    /// [Encrypt](https://docs.aws.amazon.com/kms/latest/APIReference/API_Encrypt.html) in the
    /// *Key Management Service API Reference*.
    kms_key_id: ?[]const u8 = null,

    /// The configuration for the Amazon File Cache resource being created.
    lustre_configuration: ?CreateFileCacheLustreConfiguration = null,

    /// A list of IDs specifying the security groups to apply to all network
    /// interfaces
    /// created for Amazon File Cache access. This list isn't returned in later
    /// requests to
    /// describe the cache.
    security_group_ids: ?[]const []const u8 = null,

    /// The storage capacity of the cache in gibibytes (GiB). Valid values
    /// are 1200 GiB, 2400 GiB, and increments of 2400 GiB.
    storage_capacity: i32,

    subnet_ids: []const []const u8,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .copy_tags_to_data_repository_associations = "CopyTagsToDataRepositoryAssociations",
        .data_repository_associations = "DataRepositoryAssociations",
        .file_cache_type = "FileCacheType",
        .file_cache_type_version = "FileCacheTypeVersion",
        .kms_key_id = "KmsKeyId",
        .lustre_configuration = "LustreConfiguration",
        .security_group_ids = "SecurityGroupIds",
        .storage_capacity = "StorageCapacity",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
    };
};

pub const CreateFileCacheOutput = struct {
    /// A description of the cache that was created.
    file_cache: ?FileCacheCreating = null,

    pub const json_field_names = .{
        .file_cache = "FileCache",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFileCacheInput, options: CallOptions) !CreateFileCacheOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFileCacheInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateFileCache");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFileCacheOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFileCacheOutput, body, allocator);
}
