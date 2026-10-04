const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeCollectionInput = struct {
    /// The ID of the collection to describe.
    collection_id: []const u8,

    pub const json_field_names = .{
        .collection_id = "CollectionId",
    };
};

pub const DescribeCollectionOutput = struct {
    /// The Amazon Resource Name (ARN) of the collection.
    collection_arn: ?[]const u8 = null,

    /// The number of milliseconds since the Unix epoch time until the creation of
    /// the collection.
    /// The Unix epoch time is 00:00:00 Coordinated Universal Time (UTC), Thursday,
    /// 1 January 1970.
    creation_timestamp: ?i64 = null,

    /// The number of faces that are indexed into the collection. To index faces
    /// into a
    /// collection, use IndexFaces.
    face_count: ?i64 = null,

    /// The version of the face model that's used by the collection for face
    /// detection.
    ///
    /// For more information, see Model versioning in the
    /// Amazon Rekognition Developer Guide.
    face_model_version: ?[]const u8 = null,

    /// The number of UserIDs assigned to the specified colleciton.
    user_count: ?i64 = null,

    pub const json_field_names = .{
        .collection_arn = "CollectionARN",
        .creation_timestamp = "CreationTimestamp",
        .face_count = "FaceCount",
        .face_model_version = "FaceModelVersion",
        .user_count = "UserCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCollectionInput, options: CallOptions) !DescribeCollectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCollectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DescribeCollection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCollectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCollectionOutput, body, allocator);
}
