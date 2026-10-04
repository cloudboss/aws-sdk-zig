const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FaceMatch = @import("face_match.zig").FaceMatch;

pub const SearchFacesInput = struct {
    /// ID of the collection the face belongs to.
    collection_id: []const u8,

    /// ID of a face to find matches for in the collection.
    face_id: []const u8,

    /// Optional value specifying the minimum confidence in the face match to
    /// return. For
    /// example, don't return any matches where confidence in matches is less than
    /// 70%. The default
    /// value is 80%.
    face_match_threshold: ?f32 = null,

    /// Maximum number of faces to return. The operation returns the maximum number
    /// of faces
    /// with the highest confidence in the match.
    max_faces: ?i32 = null,

    pub const json_field_names = .{
        .collection_id = "CollectionId",
        .face_id = "FaceId",
        .face_match_threshold = "FaceMatchThreshold",
        .max_faces = "MaxFaces",
    };
};

pub const SearchFacesOutput = struct {
    /// An array of faces that matched the input face, along with the confidence in
    /// the
    /// match.
    face_matches: ?[]const FaceMatch = null,

    /// Version number of the face detection model associated with the input
    /// collection
    /// (`CollectionId`).
    face_model_version: ?[]const u8 = null,

    /// ID of the face that was searched for matches in a collection.
    searched_face_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .face_matches = "FaceMatches",
        .face_model_version = "FaceModelVersion",
        .searched_face_id = "SearchedFaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchFacesInput, options: CallOptions) !SearchFacesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchFacesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.SearchFaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchFacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchFacesOutput, body, allocator);
}
