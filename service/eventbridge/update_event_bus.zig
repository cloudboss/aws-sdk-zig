const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DeadLetterConfig = @import("dead_letter_config.zig").DeadLetterConfig;
const LogConfig = @import("log_config.zig").LogConfig;

pub const UpdateEventBusInput = struct {
    dead_letter_config: ?DeadLetterConfig = null,

    /// The event bus description.
    description: ?[]const u8 = null,

    /// The identifier of the KMS
    /// customer managed key for EventBridge to use, if you choose to use a customer
    /// managed key to encrypt events on this event bus. The identifier can be the
    /// key
    /// Amazon Resource Name (ARN), KeyId, key alias, or key alias ARN.
    ///
    /// If you do not specify a customer managed key identifier, EventBridge uses an
    /// Amazon Web Services owned key to encrypt events on the event bus.
    ///
    /// For more information, see [Identify and view
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/viewing-keys.html) in the *Key Management Service
    /// Developer Guide*.
    ///
    /// Schema discovery is not supported for event buses encrypted using a
    /// customer managed key. EventBridge returns an error if:
    ///
    /// * You call `
    /// [CreateDiscoverer](https://docs.aws.amazon.com/eventbridge/latest/schema-reference/v1-discoverers.html#CreateDiscoverer)
    /// ` on an event bus set to use a customer managed key for encryption.
    ///
    /// * You call `
    /// [UpdatedEventBus](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_UpdatedEventBus.html)
    /// ` to set a customer managed key on an event bus with schema discovery
    /// enabled.
    ///
    /// To enable schema discovery on an event bus, choose to
    /// use an Amazon Web Services owned key. For more information, see [Encrypting
    /// events](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-encryption-event-bus-cmkey.html) in the *Amazon EventBridge User Guide*.
    ///
    /// If you have specified that EventBridge use a customer managed key for
    /// encrypting the source event bus, we strongly recommend you also specify a
    /// customer managed key for any archives for the event bus as well.
    ///
    /// For more information, see [Encrypting
    /// archives](https://docs.aws.amazon.com/eventbridge/latest/userguide/encryption-archives.html) in the *Amazon EventBridge User Guide*.
    kms_key_identifier: ?[]const u8 = null,

    /// The logging configuration settings for the event bus.
    ///
    /// For more information, see [Configuring logs for event
    /// buses](https://docs.aws.amazon.com/eb-event-bus-logs.html) in the
    /// *EventBridge User Guide*.
    log_config: ?LogConfig = null,

    /// The name of the event bus.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .dead_letter_config = "DeadLetterConfig",
        .description = "Description",
        .kms_key_identifier = "KmsKeyIdentifier",
        .log_config = "LogConfig",
        .name = "Name",
    };
};

pub const UpdateEventBusOutput = struct {
    /// The event bus Amazon Resource Name (ARN).
    arn: ?[]const u8 = null,

    dead_letter_config: ?DeadLetterConfig = null,

    /// The event bus description.
    description: ?[]const u8 = null,

    /// The identifier of the KMS
    /// customer managed key for EventBridge to use to encrypt events on this event
    /// bus, if one has been specified.
    ///
    /// For more information, see [Data encryption in
    /// EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-encryption.html) in the *Amazon EventBridge User Guide*.
    kms_key_identifier: ?[]const u8 = null,

    /// The logging configuration settings for the event bus.
    ///
    /// For more information, see [Configuring logs for event
    /// buses](https://docs.aws.amazon.com/eb-event-bus-logs.html) in the
    /// *EventBridge User Guide*.
    log_config: ?LogConfig = null,

    /// The event bus name.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .dead_letter_config = "DeadLetterConfig",
        .description = "Description",
        .kms_key_identifier = "KmsKeyIdentifier",
        .log_config = "LogConfig",
        .name = "Name",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEventBusInput, options: Options) !UpdateEventBusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "eventbridge");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEventBusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eventbridge", "EventBridge", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.UpdateEventBus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEventBusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateEventBusOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalStatusException")) {
        return .{ .arena = arena, .kind = .{ .illegal_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEventPatternException")) {
        return .{ .arena = arena, .kind = .{ .invalid_event_pattern_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ManagedRuleException")) {
        return .{ .arena = arena, .kind = .{ .managed_rule_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationDisabledException")) {
        return .{ .arena = arena, .kind = .{ .operation_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
