const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeadLetterConfig = @import("dead_letter_config.zig").DeadLetterConfig;
const LogConfig = @import("log_config.zig").LogConfig;

pub const DescribeEventBusInput = struct {
    /// The name or ARN of the event bus to show details for. If you omit this, the
    /// default event
    /// bus is displayed.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribeEventBusOutput = struct {
    /// The Amazon Resource Name (ARN) of the account permitted to write events to
    /// the current account.
    arn: ?[]const u8 = null,

    /// The time the event bus was created.
    creation_time: ?i64 = null,

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

    /// The time the event bus was last modified.
    last_modified_time: ?i64 = null,

    /// The logging configuration settings for the event bus.
    ///
    /// For more information, see [Configuring logs for event
    /// buses](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-bus-logs.html) in the *EventBridge User Guide*.
    log_config: ?LogConfig = null,

    /// If the event bus was created on behalf of your account by an Amazon Web
    /// Services service,
    /// this field displays the principal name of the service that created the event
    /// bus.
    managed_by: ?[]const u8 = null,

    /// The name of the event bus. Currently, this is always `default`.
    name: ?[]const u8 = null,

    /// The policy that enables the external account to send events to your account.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .dead_letter_config = "DeadLetterConfig",
        .description = "Description",
        .kms_key_identifier = "KmsKeyIdentifier",
        .last_modified_time = "LastModifiedTime",
        .log_config = "LogConfig",
        .managed_by = "ManagedBy",
        .name = "Name",
        .policy = "Policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventBusInput, options: CallOptions) !DescribeEventBusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEventBusInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.DescribeEventBus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEventBusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEventBusOutput, body, allocator);
}
