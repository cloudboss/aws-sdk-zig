const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MessageType = @import("message_type.zig").MessageType;
const NumberCapability = @import("number_capability.zig").NumberCapability;
const RequestableNumberType = @import("requestable_number_type.zig").RequestableNumberType;
const Tag = @import("tag.zig").Tag;
const NumberStatus = @import("number_status.zig").NumberStatus;

pub const RequestPhoneNumberInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If you don't specify a client token, a randomly generated
    /// token is used for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// By default this is set to false. When set to true the phone number can't be
    /// deleted.
    deletion_protection_enabled: ?bool = null,

    /// By default this is set to false. When set to true the international sending
    /// of phone number is Enabled.
    international_sending_enabled: ?bool = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// The type of message. Valid values are `TRANSACTIONAL` for messages that are
    /// critical or time-sensitive and `PROMOTIONAL` for messages that aren't
    /// critical or time-sensitive.
    message_type: MessageType,

    /// Indicates if the phone number will be used for text messages, voice
    /// messages, or both.
    number_capabilities: []const NumberCapability,

    /// The type of phone number to request.
    ///
    /// When you request a `SIMULATOR` phone number, you must set **MessageType** as
    /// `TRANSACTIONAL`.
    number_type: RequestableNumberType,

    /// The name of the OptOutList to associate with the phone number. You can use
    /// the OptOutListName or OptOutListArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    opt_out_list_name: ?[]const u8 = null,

    /// The pool to associated with the phone number. You can use the PoolId or
    /// PoolArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    pool_id: ?[]const u8 = null,

    /// Use this field to attach your phone number for an external registration
    /// process.
    registration_id: ?[]const u8 = null,

    /// An array of tags (key and value pairs) to associate with the requested phone
    /// number.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .international_sending_enabled = "InternationalSendingEnabled",
        .iso_country_code = "IsoCountryCode",
        .message_type = "MessageType",
        .number_capabilities = "NumberCapabilities",
        .number_type = "NumberType",
        .opt_out_list_name = "OptOutListName",
        .pool_id = "PoolId",
        .registration_id = "RegistrationId",
        .tags = "Tags",
    };
};

pub const RequestPhoneNumberOutput = struct {
    /// The time when the phone number was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: ?i64 = null,

    /// By default this is set to false. When set to true the phone number can't be
    /// deleted.
    deletion_protection_enabled: ?bool = null,

    /// By default this is set to false. When set to true the international sending
    /// of phone number is Enabled.
    international_sending_enabled: ?bool = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: ?[]const u8 = null,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive.
    message_type: ?MessageType = null,

    /// The monthly price, in US dollars, to lease the phone number.
    monthly_leasing_price: ?[]const u8 = null,

    /// Indicates if the phone number will be used for text messages, voice messages
    /// or both.
    number_capabilities: ?[]const NumberCapability = null,

    /// The type of number that was released.
    number_type: ?RequestableNumberType = null,

    /// The name of the OptOutList that is associated with the requested phone
    /// number.
    opt_out_list_name: ?[]const u8 = null,

    /// The new phone number that was requested.
    phone_number: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the requested phone number.
    phone_number_arn: ?[]const u8 = null,

    /// The unique identifier of the new phone number.
    phone_number_id: ?[]const u8 = null,

    /// The unique identifier of the pool associated with the phone number
    pool_id: ?[]const u8 = null,

    /// The unique identifier for the registration.
    registration_id: ?[]const u8 = null,

    /// By default this is set to false. When set to false and an end recipient
    /// sends a message that begins with HELP or STOP to one of your dedicated
    /// numbers, End User Messaging SMS automatically replies with a customizable
    /// message and adds the end recipient to the OptOutList. When set to true
    /// you're responsible for responding to HELP and STOP requests. You're also
    /// responsible for tracking and honoring opt-out requests.
    self_managed_opt_outs_enabled: ?bool = null,

    /// The current status of the request.
    status: ?NumberStatus = null,

    /// An array of key and value pair tags that are associated with the phone
    /// number.
    tags: ?[]const Tag = null,

    /// The ARN used to identify the two way channel.
    two_way_channel_arn: ?[]const u8 = null,

    /// An optional IAM Role Arn for a service to assume, to be able to post inbound
    /// SMS messages.
    two_way_channel_role: ?[]const u8 = null,

    /// By default this is set to false. When set to true you can receive incoming
    /// text messages from your end recipients.
    two_way_enabled: ?bool = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .international_sending_enabled = "InternationalSendingEnabled",
        .iso_country_code = "IsoCountryCode",
        .message_type = "MessageType",
        .monthly_leasing_price = "MonthlyLeasingPrice",
        .number_capabilities = "NumberCapabilities",
        .number_type = "NumberType",
        .opt_out_list_name = "OptOutListName",
        .phone_number = "PhoneNumber",
        .phone_number_arn = "PhoneNumberArn",
        .phone_number_id = "PhoneNumberId",
        .pool_id = "PoolId",
        .registration_id = "RegistrationId",
        .self_managed_opt_outs_enabled = "SelfManagedOptOutsEnabled",
        .status = "Status",
        .tags = "Tags",
        .two_way_channel_arn = "TwoWayChannelArn",
        .two_way_channel_role = "TwoWayChannelRole",
        .two_way_enabled = "TwoWayEnabled",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RequestPhoneNumberInput, options: Options) !RequestPhoneNumberOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: RequestPhoneNumberInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "PinpointSMSVoiceV2.RequestPhoneNumber");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RequestPhoneNumberOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RequestPhoneNumberOutput, body, alloc);
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
