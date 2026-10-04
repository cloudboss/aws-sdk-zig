const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EmailAddressConfig = @import("email_address_config.zig").EmailAddressConfig;
const OutboundCallerConfig = @import("outbound_caller_config.zig").OutboundCallerConfig;
const OutboundEmailConfig = @import("outbound_email_config.zig").OutboundEmailConfig;

pub const CreateQueueInput = struct {
    /// The description of the queue.
    description: ?[]const u8 = null,

    /// Configuration list containing the email addresses to associate with the
    /// queue during creation. Each configuration specifies an email address ID that
    /// agents can select when handling email contacts in this queue.
    email_addresses_config: ?[]const EmailAddressConfig = null,

    /// The identifier for the hours of operation.
    hours_of_operation_id: []const u8,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The maximum number of contacts that can be in the queue before it is
    /// considered full.
    max_contacts: ?i32 = null,

    /// The name of the queue.
    name: []const u8,

    /// The outbound caller ID name, number, and outbound whisper flow.
    outbound_caller_config: ?OutboundCallerConfig = null,

    /// The outbound email address ID for a specified queue.
    outbound_email_config: ?OutboundEmailConfig = null,

    /// The quick connects available to agents who are working the queue.
    quick_connect_ids: ?[]const []const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .email_addresses_config = "EmailAddressesConfig",
        .hours_of_operation_id = "HoursOfOperationId",
        .instance_id = "InstanceId",
        .max_contacts = "MaxContacts",
        .name = "Name",
        .outbound_caller_config = "OutboundCallerConfig",
        .outbound_email_config = "OutboundEmailConfig",
        .quick_connect_ids = "QuickConnectIds",
        .tags = "Tags",
    };
};

pub const CreateQueueOutput = struct {
    /// The Amazon Resource Name (ARN) of the queue.
    queue_arn: ?[]const u8 = null,

    /// The identifier for the queue.
    queue_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .queue_arn = "QueueArn",
        .queue_id = "QueueId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQueueInput, options: CallOptions) !CreateQueueOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQueueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/queues/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.email_addresses_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EmailAddressesConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"HoursOfOperationId\":");
    try aws.json.writeValue(@TypeOf(input.hours_of_operation_id), input.hours_of_operation_id, allocator, &body_buf);
    has_prev = true;
    if (input.max_contacts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxContacts\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.outbound_caller_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OutboundCallerConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.outbound_email_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OutboundEmailConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.quick_connect_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QuickConnectIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQueueOutput {
    var result: CreateQueueOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateQueueOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
