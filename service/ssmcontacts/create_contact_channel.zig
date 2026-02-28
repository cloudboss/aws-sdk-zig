const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ContactChannelAddress = @import("contact_channel_address.zig").ContactChannelAddress;
const ChannelType = @import("channel_type.zig").ChannelType;

pub const CreateContactChannelInput = struct {
    /// The Amazon Resource Name (ARN) of the contact you are adding the contact
    /// channel
    /// to.
    contact_id: []const u8,

    /// If you want to activate the channel at a later time, you can choose to defer
    /// activation.
    /// Incident Manager can't engage your contact channel until it has been
    /// activated.
    defer_activation: ?bool = null,

    /// The details that Incident Manager uses when trying to engage the contact
    /// channel. The format
    /// is dependent on the type of the contact channel. The following are the
    /// expected
    /// formats:
    ///
    /// * SMS - '+' followed by the country code and phone number
    ///
    /// * VOICE - '+' followed by the country code and phone number
    ///
    /// * EMAIL - any standard email format
    delivery_address: ContactChannelAddress,

    /// A token ensuring that the operation is called only once with the specified
    /// details.
    idempotency_token: ?[]const u8 = null,

    /// The name of the contact channel.
    name: []const u8,

    /// Incident Manager supports three types of contact channels:
    ///
    /// * `SMS`
    ///
    /// * `VOICE`
    ///
    /// * `EMAIL`
    @"type": ChannelType,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .defer_activation = "DeferActivation",
        .delivery_address = "DeliveryAddress",
        .idempotency_token = "IdempotencyToken",
        .name = "Name",
        .@"type" = "Type",
    };
};

pub const CreateContactChannelOutput = struct {
    /// The Amazon Resource Name (ARN) of the contact channel.
    contact_channel_arn: []const u8,

    pub const json_field_names = .{
        .contact_channel_arn = "ContactChannelArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContactChannelInput, options: Options) !CreateContactChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ssmcontacts");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateContactChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssmcontacts", "SSM Contacts", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SSMContacts.CreateContactChannel");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateContactChannelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateContactChannelOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "DataEncryptionException")) {
        return .{ .arena = arena, .kind = .{ .data_encryption_exception = .{
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
