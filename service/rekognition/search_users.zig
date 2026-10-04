const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchedFace = @import("searched_face.zig").SearchedFace;
const SearchedUser = @import("searched_user.zig").SearchedUser;
const UserMatch = @import("user_match.zig").UserMatch;

pub const SearchUsersInput = struct {
    /// The ID of an existing collection containing the UserID, used with a UserId
    /// or FaceId. If a
    /// FaceId is provided, UserId isn’t required to be present in the Collection.
    collection_id: []const u8,

    /// ID for the existing face.
    face_id: ?[]const u8 = null,

    /// Maximum number of identities to return.
    max_users: ?i32 = null,

    /// ID for the existing User.
    user_id: ?[]const u8 = null,

    /// Optional value that specifies the minimum confidence in the matched UserID
    /// to return.
    /// Default value of 80.
    user_match_threshold: ?f32 = null,

    pub const json_field_names = .{
        .collection_id = "CollectionId",
        .face_id = "FaceId",
        .max_users = "MaxUsers",
        .user_id = "UserId",
        .user_match_threshold = "UserMatchThreshold",
    };
};

pub const SearchUsersOutput = struct {
    /// Version number of the face detection model associated with the input
    /// CollectionId.
    face_model_version: ?[]const u8 = null,

    /// Contains the ID of a face that was used to search for matches in a
    /// collection.
    searched_face: ?SearchedFace = null,

    /// Contains the ID of the UserID that was used to search for matches in a
    /// collection.
    searched_user: ?SearchedUser = null,

    /// An array of UserMatch objects that matched the input face along with the
    /// confidence in the
    /// match. Array will be empty if there are no matches.
    user_matches: ?[]const UserMatch = null,

    pub const json_field_names = .{
        .face_model_version = "FaceModelVersion",
        .searched_face = "SearchedFace",
        .searched_user = "SearchedUser",
        .user_matches = "UserMatches",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchUsersInput, options: CallOptions) !SearchUsersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchUsersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.SearchUsers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchUsersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchUsersOutput, body, allocator);
}
