const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateFaceLivenessSessionRequestSettings = @import("create_face_liveness_session_request_settings.zig").CreateFaceLivenessSessionRequestSettings;

pub const CreateFaceLivenessSessionInput = struct {
    /// Idempotent token is used to recognize the Face Liveness request. If the same
    /// token is used
    /// with multiple `CreateFaceLivenessSession` requests, the same session is
    /// returned.
    /// This token is employed to avoid unintentionally creating the same session
    /// multiple
    /// times.
    client_request_token: ?[]const u8 = null,

    /// The identifier for your AWS Key Management Service key (AWS KMS key). Used
    /// to encrypt
    /// audit images and reference images.
    kms_key_id: ?[]const u8 = null,

    /// A session settings object. It contains settings for the operation to be
    /// performed. For
    /// Face Liveness, it accepts `OutputConfig` and `AuditImagesLimit`.
    settings: ?CreateFaceLivenessSessionRequestSettings = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .kms_key_id = "KmsKeyId",
        .settings = "Settings",
    };
};

pub const CreateFaceLivenessSessionOutput = struct {
    /// A unique 128-bit UUID identifying a Face Liveness session.
    /// A new sessionID must be used for every Face Liveness check. If a given
    /// sessionID is used for subsequent
    /// Face Liveness checks, the checks will fail. Additionally, a SessionId
    /// expires 3 minutes after it's sent,
    /// making all Liveness data associated with the session (e.g., sessionID,
    /// reference image, audit images, etc.) unavailable.
    session_id: []const u8,

    pub const json_field_names = .{
        .session_id = "SessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFaceLivenessSessionInput, options: CallOptions) !CreateFaceLivenessSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFaceLivenessSessionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.CreateFaceLivenessSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFaceLivenessSessionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateFaceLivenessSessionOutput, body, allocator);
}
