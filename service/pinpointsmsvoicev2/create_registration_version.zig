const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistrationVersionStatus = @import("registration_version_status.zig").RegistrationVersionStatus;
const RegistrationVersionStatusHistory = @import("registration_version_status_history.zig").RegistrationVersionStatusHistory;

pub const CreateRegistrationVersionInput = struct {
    /// The unique identifier for the registration.
    registration_id: []const u8,

    pub const json_field_names = .{
        .registration_id = "RegistrationId",
    };
};

pub const CreateRegistrationVersionOutput = struct {
    /// The Amazon Resource Name (ARN) for the registration.
    registration_arn: []const u8,

    /// The unique identifier for the registration.
    registration_id: []const u8,

    /// The status of the registration.
    ///
    /// * `APPROVED`: Your registration has been approved.
    /// * `ARCHIVED`: Your previously approved registration version moves into this
    ///   status when a more recently submitted version is approved.
    /// * `DENIED`: You must fix your registration and resubmit it.
    /// * `DISCARDED`: You've abandon this version of their registration to start
    ///   over with a new version.
    /// * `DRAFT`: The initial status of a registration version after it’s created.
    /// * `REQUIRES_AUTHENTICATION`: You need to complete email authentication.
    /// * `REVIEWING`: Your registration has been accepted and is being reviewed.
    /// * `REVOKED`: Your previously approved registration has been revoked.
    /// * `SUBMITTED`: Your registration has been submitted.
    registration_version_status: RegistrationVersionStatus,

    /// A **RegistrationVersionStatusHistory** object that contains timestamps for
    /// the registration.
    registration_version_status_history: ?RegistrationVersionStatusHistory = null,

    /// The new version number of the registration.
    version_number: i64,

    pub const json_field_names = .{
        .registration_arn = "RegistrationArn",
        .registration_id = "RegistrationId",
        .registration_version_status = "RegistrationVersionStatus",
        .registration_version_status_history = "RegistrationVersionStatusHistory",
        .version_number = "VersionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRegistrationVersionInput, options: CallOptions) !CreateRegistrationVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRegistrationVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.CreateRegistrationVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRegistrationVersionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateRegistrationVersionOutput, body, allocator);
}
