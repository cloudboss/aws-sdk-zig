const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationResult = @import("authentication_result.zig").AuthenticationResult;
const FraudDetectionResult = @import("fraud_detection_result.zig").FraudDetectionResult;
const StreamingStatus = @import("streaming_status.zig").StreamingStatus;

pub const EvaluateSessionInput = struct {
    /// The identifier of the domain where the session started.
    domain_id: []const u8,

    /// The session identifier, or name of the session, that you want to evaluate.
    /// In
    /// Voice ID integration, this is the Contact-Id.
    session_name_or_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .session_name_or_id = "SessionNameOrId",
    };
};

pub const EvaluateSessionOutput = struct {
    /// Details resulting from the authentication process, such as authentication
    /// decision and
    /// authentication score.
    authentication_result: ?AuthenticationResult = null,

    /// The identifier of the domain that contains the session.
    domain_id: ?[]const u8 = null,

    /// Details resulting from the fraud detection process, such as fraud detection
    /// decision
    /// and risk score.
    fraud_detection_result: ?FraudDetectionResult = null,

    /// The service-generated identifier of the session.
    session_id: ?[]const u8 = null,

    /// The client-provided name of the session.
    session_name: ?[]const u8 = null,

    /// The current status of audio streaming for this session. This field is useful
    /// to infer
    /// next steps when the Authentication or Fraud Detection results are empty or
    /// the decision
    /// is `NOT_ENOUGH_SPEECH`. In this situation, if the
    /// `StreamingStatus` is `ONGOING/PENDING_CONFIGURATION`, it can
    /// mean that the client should call the API again later, after Voice ID has
    /// enough audio
    /// to produce a result. If the decision remains `NOT_ENOUGH_SPEECH` even after
    /// `StreamingStatus` is `ENDED`, it means that the previously
    /// streamed session did not have enough speech to perform evaluation, and a new
    /// streaming
    /// session is needed to try again.
    streaming_status: ?StreamingStatus = null,

    pub const json_field_names = .{
        .authentication_result = "AuthenticationResult",
        .domain_id = "DomainId",
        .fraud_detection_result = "FraudDetectionResult",
        .session_id = "SessionId",
        .session_name = "SessionName",
        .streaming_status = "StreamingStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EvaluateSessionInput, options: CallOptions) !EvaluateSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "voiceid", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: EvaluateSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voiceid", "Voice ID", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VoiceID.EvaluateSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EvaluateSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(EvaluateSessionOutput, body, allocator);
}
