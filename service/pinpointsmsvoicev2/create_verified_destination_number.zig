const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const VerificationStatus = @import("verification_status.zig").VerificationStatus;

pub const CreateVerifiedDestinationNumberInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If you don't specify a client token, a randomly generated
    /// token is used for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The verified destination phone number, in E.164 format.
    destination_phone_number: []const u8,

    /// The unique identifier of the RCS agent to associate with the verified
    /// destination number. You can use either the RcsAgentId or RcsAgentArn.
    rcs_agent_id: ?[]const u8 = null,

    /// An array of tags (key and value pairs) to associate with the destination
    /// number.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .destination_phone_number = "DestinationPhoneNumber",
        .rcs_agent_id = "RcsAgentId",
        .tags = "Tags",
    };
};

pub const CreateVerifiedDestinationNumberOutput = struct {
    /// The time when the verified phone number was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The verified destination phone number, in E.164 format.
    destination_phone_number: []const u8,

    /// The unique identifier of the RCS agent associated with the verified
    /// destination number.
    rcs_agent_id: ?[]const u8 = null,

    /// The status of the verified destination phone number.
    ///
    /// * `PENDING`: The phone number hasn't been verified yet.
    /// * `VERIFIED`: The phone number is verified and can receive messages.
    status: VerificationStatus,

    /// An array of tags (key and value pairs) to associate with the destination
    /// number.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) for the verified destination phone number.
    verified_destination_number_arn: []const u8,

    /// The unique identifier for the verified destination phone number.
    verified_destination_number_id: []const u8,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .destination_phone_number = "DestinationPhoneNumber",
        .rcs_agent_id = "RcsAgentId",
        .status = "Status",
        .tags = "Tags",
        .verified_destination_number_arn = "VerifiedDestinationNumberArn",
        .verified_destination_number_id = "VerifiedDestinationNumberId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVerifiedDestinationNumberInput, options: CallOptions) !CreateVerifiedDestinationNumberOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVerifiedDestinationNumberInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.CreateVerifiedDestinationNumber");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVerifiedDestinationNumberOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateVerifiedDestinationNumberOutput, body, allocator);
}
