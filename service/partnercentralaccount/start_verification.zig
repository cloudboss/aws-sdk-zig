const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VerificationDetails = @import("verification_details.zig").VerificationDetails;
const VerificationResponseDetails = @import("verification_response_details.zig").VerificationResponseDetails;
const VerificationStatus = @import("verification_status.zig").VerificationStatus;
const VerificationType = @import("verification_type.zig").VerificationType;

pub const StartVerificationInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. This prevents duplicate verification processes
    /// from being started accidentally.
    client_token: ?[]const u8 = null,

    /// The specific details required for the verification process, including
    /// business information for business verification or personal information for
    /// registrant verification.
    verification_details: ?VerificationDetails = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .verification_details = "VerificationDetails",
    };
};

pub const StartVerificationOutput = struct {
    /// The timestamp when the verification process was completed. This field is
    /// typically null for newly started verifications unless they complete
    /// immediately.
    completed_at: ?i64 = null,

    /// The timestamp when the verification process was successfully initiated.
    started_at: i64,

    /// Initial response details specific to the type of verification started, which
    /// may include next steps or additional requirements.
    verification_response_details: ?VerificationResponseDetails = null,

    /// The initial status of the verification process after it has been started.
    /// Typically this will be pending or in-progress.
    verification_status: VerificationStatus,

    /// Additional information about the initial verification status, including any
    /// immediate feedback about the submitted verification details.
    verification_status_reason: ?[]const u8 = null,

    /// The type of verification that was started based on the provided verification
    /// details.
    verification_type: VerificationType,

    pub const json_field_names = .{
        .completed_at = "CompletedAt",
        .started_at = "StartedAt",
        .verification_response_details = "VerificationResponseDetails",
        .verification_status = "VerificationStatus",
        .verification_status_reason = "VerificationStatusReason",
        .verification_type = "VerificationType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartVerificationInput, options: CallOptions) !StartVerificationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartVerificationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-account", "PartnerCentral Account", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.StartVerification");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartVerificationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartVerificationOutput, body, allocator);
}
