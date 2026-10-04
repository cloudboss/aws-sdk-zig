const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    /// buses](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-bus-logs.html) in the *EventBridge User Guide*.
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
    /// buses](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-bus-logs.html) in the *EventBridge User Guide*.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEventBusInput, options: CallOptions) !UpdateEventBusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEventBusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "EventBridge", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
