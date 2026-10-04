const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeletionProtection = @import("deletion_protection.zig").DeletionProtection;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;
const StandbyReplicas = @import("standby_replicas.zig").StandbyReplicas;
const Tag = @import("tag.zig").Tag;
const CollectionType = @import("collection_type.zig").CollectionType;
const VectorOptions = @import("vector_options.zig").VectorOptions;
const CreateCollectionDetail = @import("create_collection_detail.zig").CreateCollectionDetail;

pub const CreateCollectionInput = struct {
    /// Unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The name of the collection group to associate with the collection.
    collection_group_name: ?[]const u8 = null,

    /// Indicates whether to enable deletion protection for the collection. When set
    /// to `ENABLED`, the collection cannot be deleted.
    deletion_protection: ?DeletionProtection = null,

    /// Description of the collection.
    description: ?[]const u8 = null,

    /// Encryption settings for the collection.
    encryption_config: ?EncryptionConfig = null,

    /// Name of the collection.
    name: []const u8,

    /// Indicates whether standby replicas should be used for a collection.
    standby_replicas: ?StandbyReplicas = null,

    /// An arbitrary set of tags (key–value pairs) to associate with the OpenSearch
    /// Serverless collection.
    tags: ?[]const Tag = null,

    /// The type of collection.
    @"type": ?CollectionType = null,

    /// Configuration options for vector search capabilities in the collection.
    vector_options: ?VectorOptions = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .collection_group_name = "collectionGroupName",
        .deletion_protection = "deletionProtection",
        .description = "description",
        .encryption_config = "encryptionConfig",
        .name = "name",
        .standby_replicas = "standbyReplicas",
        .tags = "tags",
        .@"type" = "type",
        .vector_options = "vectorOptions",
    };
};

pub const CreateCollectionOutput = struct {
    /// Details about the collection.
    create_collection_detail: ?CreateCollectionDetail = null,

    pub const json_field_names = .{
        .create_collection_detail = "createCollectionDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCollectionInput, options: CallOptions) !CreateCollectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aoss", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCollectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aoss", "OpenSearchServerless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.CreateCollection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCollectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCollectionOutput, body, allocator);
}
