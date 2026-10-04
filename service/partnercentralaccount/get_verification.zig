const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VerificationType = @import("verification_type.zig").VerificationType;
const VerificationResponseDetails = @import("verification_response_details.zig").VerificationResponseDetails;
const VerificationStatus = @import("verification_status.zig").VerificationStatus;

pub const GetVerificationInput = struct {
    /// The type of verification to retrieve information for. Valid values include
    /// business verification for company registration details and registrant
    /// verification for individual identity confirmation.
    verification_type: VerificationType,

    pub const json_field_names = .{
        .verification_type = "VerificationType",
    };
};

pub const GetVerificationOutput = struct {
    /// The timestamp when the verification process was completed. This field is
    /// null if the verification is still in progress.
    completed_at: ?i64 = null,

    /// The timestamp when the verification process was initiated.
    started_at: i64,

    /// Detailed response information specific to the type of verification
    /// performed, including any verification-specific data or results.
    verification_response_details: ?VerificationResponseDetails = null,

    /// The current status of the verification process. Possible values include
    /// pending, in-progress, completed, failed, or expired.
    verification_status: VerificationStatus,

    /// Additional information explaining the current verification status,
    /// particularly useful when the status indicates a failure or requires
    /// additional action.
    verification_status_reason: ?[]const u8 = null,

    /// The type of verification that was requested and processed.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetVerificationInput, options: CallOptions) !GetVerificationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetVerificationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralAccount.GetVerification");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetVerificationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetVerificationOutput, body, allocator);
}
