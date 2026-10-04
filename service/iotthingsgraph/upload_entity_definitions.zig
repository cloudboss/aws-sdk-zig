const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DefinitionDocument = @import("definition_document.zig").DefinitionDocument;

pub const UploadEntityDefinitionsInput = struct {
    /// A Boolean that specifies whether to deprecate all entities in the latest
    /// version before uploading the new `DefinitionDocument`.
    /// If set to `true`, the upload will create a new namespace version.
    deprecate_existing_entities: ?bool = null,

    /// The `DefinitionDocument` that defines the updated entities.
    document: ?DefinitionDocument = null,

    /// A Boolean that specifies whether to synchronize with the latest version of
    /// the public namespace. If set to `true`, the upload will create a new
    /// namespace version.
    sync_with_public_namespace: ?bool = null,

    pub const json_field_names = .{
        .deprecate_existing_entities = "deprecateExistingEntities",
        .document = "document",
        .sync_with_public_namespace = "syncWithPublicNamespace",
    };
};

pub const UploadEntityDefinitionsOutput = struct {
    /// The ID that specifies the upload action. You can use this to track the
    /// status of the upload.
    upload_id: []const u8,

    pub const json_field_names = .{
        .upload_id = "uploadId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UploadEntityDefinitionsInput, options: CallOptions) !UploadEntityDefinitionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotthingsgraph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UploadEntityDefinitionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotthingsgraph", "IoTThingsGraph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "IotThingsGraphFrontEndService.UploadEntityDefinitions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UploadEntityDefinitionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UploadEntityDefinitionsOutput, body, allocator);
}
