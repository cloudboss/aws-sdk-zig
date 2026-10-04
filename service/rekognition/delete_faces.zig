const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UnsuccessfulFaceDeletion = @import("unsuccessful_face_deletion.zig").UnsuccessfulFaceDeletion;

pub const DeleteFacesInput = struct {
    /// Collection from which to remove the specific faces.
    collection_id: []const u8,

    /// An array of face IDs to delete.
    face_ids: []const []const u8,

    pub const json_field_names = .{
        .collection_id = "CollectionId",
        .face_ids = "FaceIds",
    };
};

pub const DeleteFacesOutput = struct {
    /// An array of strings (face IDs) of the faces that were deleted.
    deleted_faces: ?[]const []const u8 = null,

    /// An array of any faces that weren't deleted.
    unsuccessful_face_deletions: ?[]const UnsuccessfulFaceDeletion = null,

    pub const json_field_names = .{
        .deleted_faces = "DeletedFaces",
        .unsuccessful_face_deletions = "UnsuccessfulFaceDeletions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFacesInput, options: CallOptions) !DeleteFacesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFacesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DeleteFaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteFacesOutput, body, allocator);
}
