const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MessageType = @import("message_type.zig").MessageType;
const Tag = @import("tag.zig").Tag;

pub const RequestSenderIdInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If you don't specify a client token, a randomly generated
    /// token is used for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// By default this is set to false. When set to true the sender ID can't be
    /// deleted.
    deletion_protection_enabled: ?bool = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive.
    message_types: ?[]const MessageType = null,

    /// The sender ID string to request.
    sender_id: []const u8,

    /// An array of tags (key and value pairs) to associate with the sender ID.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .iso_country_code = "IsoCountryCode",
        .message_types = "MessageTypes",
        .sender_id = "SenderId",
        .tags = "Tags",
    };
};

pub const RequestSenderIdOutput = struct {
    /// By default this is set to false. When set to true the sender ID can't be
    /// deleted.
    deletion_protection_enabled: ?bool = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive.
    message_types: ?[]const MessageType = null,

    /// The monthly price, in US dollars, to lease the sender ID.
    monthly_leasing_price: []const u8,

    /// True if the sender ID is registered.
    registered: ?bool = null,

    /// The sender ID that was requested.
    sender_id: []const u8,

    /// The Amazon Resource Name (ARN) associated with the SenderId.
    sender_id_arn: []const u8,

    /// An array of tags (key and value pairs) to associate with the sender ID.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .iso_country_code = "IsoCountryCode",
        .message_types = "MessageTypes",
        .monthly_leasing_price = "MonthlyLeasingPrice",
        .registered = "Registered",
        .sender_id = "SenderId",
        .sender_id_arn = "SenderIdArn",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RequestSenderIdInput, options: CallOptions) !RequestSenderIdOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RequestSenderIdInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.RequestSenderId");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RequestSenderIdOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(RequestSenderIdOutput, body, allocator);
}
