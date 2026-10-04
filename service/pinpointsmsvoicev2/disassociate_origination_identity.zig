const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DisassociateOriginationIdentityInput = struct {
    /// Unique, case-sensitive identifier you provide to ensure the idempotency of
    /// the request. If you don't specify a client token, a randomly generated token
    /// is used for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region. This field is optional and is not required for origination identity
    /// types that are not country-specific, such as RCS agents.
    iso_country_code: ?[]const u8 = null,

    /// The origination identity to use such as a PhoneNumberId, PhoneNumberArn,
    /// SenderId or SenderIdArn. You can use DescribePhoneNumbers find the values
    /// for PhoneNumberId and PhoneNumberArn, or use DescribeSenderIds to get the
    /// values for SenderId and SenderIdArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    origination_identity: []const u8,

    /// The unique identifier for the pool to disassociate with the origination
    /// identity. This value can be either the PoolId or PoolArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    pool_id: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .iso_country_code = "IsoCountryCode",
        .origination_identity = "OriginationIdentity",
        .pool_id = "PoolId",
    };
};

pub const DisassociateOriginationIdentityOutput = struct {
    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: ?[]const u8 = null,

    /// The PhoneNumberId or SenderId of the origination identity.
    origination_identity: ?[]const u8 = null,

    /// The PhoneNumberArn or SenderIdArn of the origination identity.
    origination_identity_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the pool.
    pool_arn: ?[]const u8 = null,

    /// The PoolId of the pool no longer associated with the origination identity.
    pool_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .iso_country_code = "IsoCountryCode",
        .origination_identity = "OriginationIdentity",
        .origination_identity_arn = "OriginationIdentityArn",
        .pool_arn = "PoolArn",
        .pool_id = "PoolId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateOriginationIdentityInput, options: CallOptions) !DisassociateOriginationIdentityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateOriginationIdentityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DisassociateOriginationIdentity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateOriginationIdentityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociateOriginationIdentityOutput, body, allocator);
}
