const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const KeywordAction = @import("keyword_action.zig").KeywordAction;

pub const PutKeywordInput = struct {
    /// The new keyword to add.
    keyword: []const u8,

    /// The action to perform for the new keyword when it is received.
    ///
    /// * AUTOMATIC_RESPONSE: A message is sent to the recipient.
    /// * OPT_OUT: Keeps the recipient from receiving future messages.
    /// * OPT_IN: The recipient wants to receive future messages.
    keyword_action: ?KeywordAction = null,

    /// The message associated with the keyword.
    keyword_message: []const u8,

    /// The origination identity to use such as a PhoneNumberId, PhoneNumberArn,
    /// SenderId or SenderIdArn. You can use DescribePhoneNumbers get the values for
    /// PhoneNumberId and PhoneNumberArn while DescribeSenderIds can be used to get
    /// the values for SenderId and SenderIdArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    origination_identity: []const u8,

    pub const json_field_names = .{
        .keyword = "Keyword",
        .keyword_action = "KeywordAction",
        .keyword_message = "KeywordMessage",
        .origination_identity = "OriginationIdentity",
    };
};

pub const PutKeywordOutput = struct {
    /// The keyword that was added.
    keyword: ?[]const u8 = null,

    /// The action to perform when the keyword is used.
    keyword_action: ?KeywordAction = null,

    /// The message associated with the keyword.
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutKeywordInput, options: Options) !PutKeywordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "pinpointsmsvoicev2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutKeywordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpointsmsvoicev2", "Pinpoint SMS Voice V2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "PinpointSMSVoiceV2.PutKeyword");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutKeywordOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutKeywordOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
