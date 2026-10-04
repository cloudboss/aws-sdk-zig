const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateRegistrationAssociationInput = struct {
    /// The unique identifier for the registration.
    registration_id: []const u8,

    /// The unique identifier for the origination identity. For example this could
    /// be a **PhoneNumberId** or **SenderId**.
    resource_id: []const u8,

    pub const json_field_names = .{
        .registration_id = "RegistrationId",
        .resource_id = "ResourceId",
    };
};

pub const CreateRegistrationAssociationOutput = struct {
    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: ?[]const u8 = null,

    /// The phone number associated with the registration in E.164 format.
    phone_number: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the registration.
    registration_arn: []const u8,

    /// The unique identifier for the registration.
    registration_id: []const u8,

    /// The type of registration form. The list of **RegistrationTypes** can be
    /// found using the DescribeRegistrationTypeDefinitions action.
    registration_type: []const u8,

    /// The Amazon Resource Name (ARN) of the origination identity that is
    /// associated with the registration.
    resource_arn: []const u8,

    /// The unique identifier for the origination identity. For example this could
    /// be a **PhoneNumberId** or **SenderId**.
    resource_id: []const u8,

    /// The registration type or origination identity type.
    resource_type: []const u8,

    pub const json_field_names = .{
        .iso_country_code = "IsoCountryCode",
        .phone_number = "PhoneNumber",
        .registration_arn = "RegistrationArn",
        .registration_id = "RegistrationId",
        .registration_type = "RegistrationType",
        .resource_arn = "ResourceArn",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRegistrationAssociationInput, options: CallOptions) !CreateRegistrationAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRegistrationAssociationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.CreateRegistrationAssociation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRegistrationAssociationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateRegistrationAssociationOutput, body, allocator);
}
