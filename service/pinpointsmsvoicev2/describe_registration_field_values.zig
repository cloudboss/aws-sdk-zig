const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistrationFieldValueInformation = @import("registration_field_value_information.zig").RegistrationFieldValueInformation;

pub const DescribeRegistrationFieldValuesInput = struct {
    /// An array of paths to the registration form field.
    field_paths: ?[]const []const u8 = null,

    /// The maximum number of results to return per each request.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results. You don't need
    /// to supply a value for this field in the initial request.
    next_token: ?[]const u8 = null,

    /// The unique identifier for the registration.
    registration_id: []const u8,

    /// The path to the section of the registration.
    section_path: ?[]const u8 = null,

    /// The version number of the registration.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .field_paths = "FieldPaths",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .registration_id = "RegistrationId",
        .section_path = "SectionPath",
        .version_number = "VersionNumber",
    };
};

pub const DescribeRegistrationFieldValuesOutput = struct {
    /// The token to be used for the next set of paginated results. You don't need
    /// to supply a value for this field in the initial request.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the registration.
    registration_arn: []const u8,

    /// An array of RegistrationFieldValues objects that contain the values for the
    /// requested registration.
    registration_field_values: ?[]const RegistrationFieldValueInformation = null,

    /// The unique identifier for the registration.
    registration_id: []const u8,

    /// The current version of the registration.
    version_number: i64,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .registration_arn = "RegistrationArn",
        .registration_field_values = "RegistrationFieldValues",
        .registration_id = "RegistrationId",
        .version_number = "VersionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRegistrationFieldValuesInput, options: CallOptions) !DescribeRegistrationFieldValuesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRegistrationFieldValuesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DescribeRegistrationFieldValues");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRegistrationFieldValuesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeRegistrationFieldValuesOutput, body, allocator);
}
