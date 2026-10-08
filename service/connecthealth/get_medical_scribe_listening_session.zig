const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MedicalScribeListeningSessionDetails = @import("medical_scribe_listening_session_details.zig").MedicalScribeListeningSessionDetails;

pub const GetMedicalScribeListeningSessionInput = struct {
    /// The Domain identifier
    domain_id: []const u8,

    /// The Session identifier
    session_id: []const u8,

    /// The Subscription identifier
    subscription_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .session_id = "sessionId",
        .subscription_id = "subscriptionId",
    };
};

pub const GetMedicalScribeListeningSessionOutput = struct {
    /// Details about the Medical Scribe listening session
    medical_scribe_listening_session_details: ?MedicalScribeListeningSessionDetails = null,

    pub const json_field_names = .{
        .medical_scribe_listening_session_details = "medicalScribeListeningSessionDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMedicalScribeListeningSessionInput, options: CallOptions) !GetMedicalScribeListeningSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "health-agent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMedicalScribeListeningSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health-agent", "ConnectHealth", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/medical-scribe-stream/domain/");
    try path_buf.appendSlice(allocator, input.domain_id);
    try path_buf.appendSlice(allocator, "/subscription/");
    try path_buf.appendSlice(allocator, input.subscription_id);
    try path_buf.appendSlice(allocator, "/session/");
    try path_buf.appendSlice(allocator, input.session_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMedicalScribeListeningSessionOutput {
    const result: GetMedicalScribeListeningSessionOutput = try aws.json.parseJsonObject(
        GetMedicalScribeListeningSessionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
