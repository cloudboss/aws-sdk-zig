const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateCollectionInput = struct {
    /// ID for the collection that you are creating.
    collection_id: []const u8,

    /// A set of tags (key-value pairs) that you want to attach to the collection.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .collection_id = "CollectionId",
        .tags = "Tags",
    };
};

pub const CreateCollectionOutput = struct {
    /// Amazon Resource Name (ARN) of the collection. You can use this to manage
    /// permissions on
    /// your resources.
    collection_arn: ?[]const u8 = null,

    /// Version number of the face detection model associated with the collection
    /// you are
    /// creating.
    face_model_version: ?[]const u8 = null,

    /// HTTP status code indicating the result of the operation.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .collection_arn = "CollectionArn",
        .face_model_version = "FaceModelVersion",
        .status_code = "StatusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCollectionInput, options: CallOptions) !CreateCollectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.CreateCollection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCollectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCollectionOutput, body, allocator);
}
