const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteRegistrationFieldValueInput = struct {
    /// The path to the registration form field. You can use
    /// DescribeRegistrationFieldDefinitions for a list of **FieldPaths**.
    field_path: []const u8,

    /// The unique identifier for the registration.
    registration_id: []const u8,

    pub const json_field_names = .{
        .field_path = "FieldPath",
        .registration_id = "RegistrationId",
    };
};

pub const DeleteRegistrationFieldValueOutput = struct {
    /// The path to the registration form field.
    field_path: []const u8,

    /// The Amazon Resource Name (ARN) for the registration.
    registration_arn: []const u8,

    /// The unique identifier for the registration attachment.
    registration_attachment_id: ?[]const u8 = null,

    /// The unique identifier for the registration.
    registration_id: []const u8,

    /// An array of values for the form field.
    select_choices: ?[]const []const u8 = null,

    /// The text data for a free form field.
    text_value: ?[]const u8 = null,

    /// The version number of the registration.
    version_number: i64,

    pub const json_field_names = .{
        .field_path = "FieldPath",
        .registration_arn = "RegistrationArn",
        .registration_attachment_id = "RegistrationAttachmentId",
        .registration_id = "RegistrationId",
        .select_choices = "SelectChoices",
        .text_value = "TextValue",
        .version_number = "VersionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRegistrationFieldValueInput, options: CallOptions) !DeleteRegistrationFieldValueOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRegistrationFieldValueInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DeleteRegistrationFieldValue");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRegistrationFieldValueOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteRegistrationFieldValueOutput, body, allocator);
}
