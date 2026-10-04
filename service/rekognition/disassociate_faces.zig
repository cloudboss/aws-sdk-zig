const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DisassociatedFace = @import("disassociated_face.zig").DisassociatedFace;
const UnsuccessfulFaceDisassociation = @import("unsuccessful_face_disassociation.zig").UnsuccessfulFaceDisassociation;
const UserStatus = @import("user_status.zig").UserStatus;

pub const DisassociateFacesInput = struct {
    /// Idempotent token used to identify the request to `DisassociateFaces`. If you
    /// use the same token with multiple `DisassociateFaces` requests, the same
    /// response is
    /// returned. Use ClientRequestToken to prevent the same request from being
    /// processed more than
    /// once.
    client_request_token: ?[]const u8 = null,

    /// The ID of an existing collection containing the UserID.
    collection_id: []const u8,

    /// An array of face IDs to disassociate from the UserID.
    face_ids: []const []const u8,

    /// ID for the existing UserID.
    user_id: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .collection_id = "CollectionId",
        .face_ids = "FaceIds",
        .user_id = "UserId",
    };
};

pub const DisassociateFacesOutput = struct {
    /// An array of DissociatedFace objects containing FaceIds that are successfully
    /// disassociated
    /// with the UserID is returned. Returned if the DisassociatedFaces action is
    /// successful.
    disassociated_faces: ?[]const DisassociatedFace = null,

    /// An array of UnsuccessfulDisassociation objects containing FaceIds that are
    /// not
    /// successfully associated, along with the reasons for the failure to
    /// associate. Returned if the
    /// DisassociateFaces action is successful.
    unsuccessful_face_disassociations: ?[]const UnsuccessfulFaceDisassociation = null,

    /// The status of an update made to a User. Reflects if the User has been
    /// updated for every
    /// requested change.
    user_status: ?UserStatus = null,

    pub const json_field_names = .{
        .disassociated_faces = "DisassociatedFaces",
        .unsuccessful_face_disassociations = "UnsuccessfulFaceDisassociations",
        .user_status = "UserStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateFacesInput, options: CallOptions) !DisassociateFacesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateFacesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DisassociateFaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateFacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociateFacesOutput, body, allocator);
}
