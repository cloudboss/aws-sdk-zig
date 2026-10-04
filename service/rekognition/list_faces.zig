const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Face = @import("face.zig").Face;

pub const ListFacesInput = struct {
    /// ID of the collection from which to list the faces.
    collection_id: []const u8,

    /// An array of face IDs to filter results with when listing faces in a
    /// collection.
    face_ids: ?[]const []const u8 = null,

    /// Maximum number of faces to return.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there is more data to
    /// retrieve),
    /// Amazon Rekognition returns a pagination token in the response. You can use
    /// this pagination token to
    /// retrieve the next set of faces.
    next_token: ?[]const u8 = null,

    /// An array of user IDs to filter results with when listing faces in a
    /// collection.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .collection_id = "CollectionId",
        .face_ids = "FaceIds",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .user_id = "UserId",
    };
};

pub const ListFacesOutput = struct {
    /// Version number of the face detection model associated with the input
    /// collection
    /// (`CollectionId`).
    face_model_version: ?[]const u8 = null,

    /// An array of `Face` objects.
    faces: ?[]const Face = null,

    /// If the response is truncated, Amazon Rekognition returns this token that you
    /// can use in the
    /// subsequent request to retrieve the next set of faces.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .face_model_version = "FaceModelVersion",
        .faces = "Faces",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFacesInput, options: CallOptions) !ListFacesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFacesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.ListFaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListFacesOutput, body, allocator);
}
