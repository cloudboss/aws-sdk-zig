const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;

pub const CreateRegistrationInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If you don't specify a client token, a randomly generated
    /// token is used for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The type of registration form to create. The list of **RegistrationTypes**
    /// can be found using the DescribeRegistrationTypeDefinitions action.
    registration_type: []const u8,

    /// An array of tags (key and value pairs) to associate with the registration.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .registration_type = "RegistrationType",
        .tags = "Tags",
    };
};

pub const CreateRegistrationOutput = struct {
    /// Metadata about a given registration which is specific to that registration
    /// type.
    additional_attributes: ?[]const aws.map.StringMapEntry = null,

    /// The time when the registration was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The current version number of the registration.
    current_version_number: i64,

    /// The Amazon Resource Name (ARN) for the registration.
    registration_arn: []const u8,

    /// The unique identifier for the registration.
    registration_id: []const u8,

    /// The status of the registration.
    ///
    /// * `CLOSED`: The phone number or sender ID has been deleted and you must also
    ///   delete the registration for the number.
    /// * `CREATED`: Your registration is created but not submitted.
    /// * `COMPLETE`: Your registration has been approved and your origination
    ///   identity has been created.
    /// * `DELETED`: The registration has been deleted.
    /// * `PROVISIONING`: Your registration has been approved and your origination
    ///   identity is being created.
    /// * `REQUIRES_AUTHENTICATION`: You need to complete email authentication.
    /// * `REQUIRES_UPDATES`: You must fix your registration and resubmit it.
    /// * `REVIEWING`: Your registration has been accepted and is being reviewed.
    /// * `SUBMITTED`: Your registration has been submitted and is awaiting review.
    registration_status: RegistrationStatus,

    /// The type of registration form to create. The list of **RegistrationTypes**
    /// can be found using the DescribeRegistrationTypeDefinitions action.
    registration_type: []const u8,

    /// An array of tags (key and value pairs) to associate with the registration.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .additional_attributes = "AdditionalAttributes",
        .created_timestamp = "CreatedTimestamp",
        .current_version_number = "CurrentVersionNumber",
        .registration_arn = "RegistrationArn",
        .registration_id = "RegistrationId",
        .registration_status = "RegistrationStatus",
        .registration_type = "RegistrationType",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRegistrationInput, options: CallOptions) !CreateRegistrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRegistrationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.CreateRegistration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRegistrationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateRegistrationOutput, body, allocator);
}
