const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MessageType = @import("message_type.zig").MessageType;
const Tag = @import("tag.zig").Tag;
const PoolStatus = @import("pool_status.zig").PoolStatus;

pub const CreatePoolInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If you don't specify a client token, a randomly generated
    /// token is used for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// By default this is set to false. When set to true the pool can't be deleted.
    /// You can change this value using the
    /// [UpdatePool](https://docs.aws.amazon.com/pinpoint/latest/apireference_smsvoicev2/API_UpdatePool.html) action.
    deletion_protection_enabled: ?bool = null,

    /// The new two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region of the new pool.
    iso_country_code: []const u8,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive. After the pool is created the MessageType can't be
    /// changed.
    message_type: MessageType,

    /// The origination identity to use such as a PhoneNumberId, PhoneNumberArn,
    /// SenderId or SenderIdArn. You can use
    /// [DescribePhoneNumbers](https://docs.aws.amazon.com/pinpoint/latest/apireference_smsvoicev2/API_DescribePhoneNumbers.html) to find the values for PhoneNumberId and PhoneNumberArn, and use [DescribeSenderIds](https://docs.aws.amazon.com/pinpoint/latest/apireference_smsvoicev2/API_DescribeSenderIds.html) can be used to get the values for SenderId and SenderIdArn.
    ///
    /// After the pool is created you can add more origination identities to the
    /// pool by using
    /// [AssociateOriginationIdentity](https://docs.aws.amazon.com/pinpoint/latest/apireference_smsvoicev2/API_AssociateOriginationIdentity.html).
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    origination_identity: []const u8,

    /// An array of tags (key and value pairs) associated with the pool.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .iso_country_code = "IsoCountryCode",
        .message_type = "MessageType",
        .origination_identity = "OriginationIdentity",
        .tags = "Tags",
    };
};

pub const CreatePoolOutput = struct {
    /// The time when the pool was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: ?i64 = null,

    /// When set to true deletion protection is enabled. By default this is set to
    /// false.
    deletion_protection_enabled: ?bool = null,

    /// The type of message for the pool to use.
    message_type: ?MessageType = null,

    /// The name of the OptOutList associated with the pool.
    opt_out_list_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the pool.
    pool_arn: ?[]const u8 = null,

    /// The unique identifier for the pool.
    pool_id: ?[]const u8 = null,

    /// By default this is set to false. When set to false, and an end recipient
    /// sends a message that begins with HELP or STOP to one of your dedicated
    /// numbers, End User Messaging SMS automatically replies with a customizable
    /// message and adds the end recipient to the OptOutList. When set to true
    /// you're responsible for responding to HELP and STOP requests. You're also
    /// responsible for tracking and honoring opt-out requests.
    self_managed_opt_outs_enabled: ?bool = null,

    /// Indicates whether shared routes are enabled for the pool. Set to false and
    /// only origination identities in this pool are used to send messages.
    shared_routes_enabled: ?bool = null,

    /// The current status of the pool.
    ///
    /// * CREATING: The pool is currently being created and isn't yet available for
    ///   use.
    /// * ACTIVE: The pool is active and available for use.
    /// * DELETING: The pool is being deleted.
    status: ?PoolStatus = null,

    /// An array of tags (key and value pairs) associated with the pool.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the two way channel.
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
        .message_type = "MessageType",
        .opt_out_list_name = "OptOutListName",
        .pool_arn = "PoolArn",
        .pool_id = "PoolId",
        .self_managed_opt_outs_enabled = "SelfManagedOptOutsEnabled",
        .shared_routes_enabled = "SharedRoutesEnabled",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePoolInput, options: Options) !CreatePoolOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpointsmsvoicev2", "Pinpoint SMS Voice V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.CreatePool");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePoolOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePoolOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
