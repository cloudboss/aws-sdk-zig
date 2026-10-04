const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteVerifiedDestinationNumberInput = struct {
    /// The unique identifier for the verified destination phone number.
    verified_destination_number_id: []const u8,

    pub const json_field_names = .{
        .verified_destination_number_id = "VerifiedDestinationNumberId",
    };
};

pub const DeleteVerifiedDestinationNumberOutput = struct {
    /// The time when the destination phone number was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The verified destination phone number, in E.164 format.
    destination_phone_number: []const u8,

    /// The Amazon Resource Name (ARN) for the verified destination phone number.
    verified_destination_number_arn: []const u8,

    /// The unique identifier for the verified destination phone number.
    verified_destination_number_id: []const u8,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .destination_phone_number = "DestinationPhoneNumber",
        .verified_destination_number_arn = "VerifiedDestinationNumberArn",
        .verified_destination_number_id = "VerifiedDestinationNumberId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteVerifiedDestinationNumberInput, options: CallOptions) !DeleteVerifiedDestinationNumberOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteVerifiedDestinationNumberInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DeleteVerifiedDestinationNumber");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteVerifiedDestinationNumberOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteVerifiedDestinationNumberOutput, body, allocator);
}
