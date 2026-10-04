const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeywordAction = @import("keyword_action.zig").KeywordAction;

pub const DeleteKeywordInput = struct {
    /// The keyword to delete.
    keyword: []const u8,

    /// The origination identity to use such as a PhoneNumberId, PhoneNumberArn,
    /// PoolId or PoolArn. You can use DescribePhoneNumbers to find the values for
    /// PhoneNumberId and PhoneNumberArn and DescribePools to find the values of
    /// PoolId and PoolArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    origination_identity: []const u8,

    pub const json_field_names = .{
        .keyword = "Keyword",
        .origination_identity = "OriginationIdentity",
    };
};

pub const DeleteKeywordOutput = struct {
    /// The keyword that was deleted.
    keyword: ?[]const u8 = null,

    /// The action that was associated with the deleted keyword.
    keyword_action: ?KeywordAction = null,

    /// The message that was associated with the deleted keyword.
    keyword_message: ?[]const u8 = null,

    /// The PhoneNumberId or PoolId that the keyword was associated with.
    origination_identity: ?[]const u8 = null,

    /// The PhoneNumberArn or PoolArn that the keyword was associated with.
    origination_identity_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .keyword = "Keyword",
        .keyword_action = "KeywordAction",
        .keyword_message = "KeywordMessage",
        .origination_identity = "OriginationIdentity",
        .origination_identity_arn = "OriginationIdentityArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteKeywordInput, options: CallOptions) !DeleteKeywordOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteKeywordInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DeleteKeyword");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteKeywordOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteKeywordOutput, body, allocator);
}
