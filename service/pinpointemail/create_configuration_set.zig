const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeliveryOptions = @import("delivery_options.zig").DeliveryOptions;
const ReputationOptions = @import("reputation_options.zig").ReputationOptions;
const SendingOptions = @import("sending_options.zig").SendingOptions;
const Tag = @import("tag.zig").Tag;
const TrackingOptions = @import("tracking_options.zig").TrackingOptions;

pub const CreateConfigurationSetInput = struct {
    /// The name of the configuration set.
    configuration_set_name: []const u8,

    /// An object that defines the dedicated IP pool that is used to send emails
    /// that you send
    /// using the configuration set.
    delivery_options: ?DeliveryOptions = null,

    /// An object that defines whether or not Amazon Pinpoint collects reputation
    /// metrics for the emails
    /// that you send that use the configuration set.
    reputation_options: ?ReputationOptions = null,

    /// An object that defines whether or not Amazon Pinpoint can send email that
    /// you send using the
    /// configuration set.
    sending_options: ?SendingOptions = null,

    /// An array of objects that define the tags (keys and values) that you want to
    /// associate
    /// with the configuration set.
    tags: ?[]const Tag = null,

    /// An object that defines the open and click tracking options for emails that
    /// you send
    /// using the configuration set.
    tracking_options: ?TrackingOptions = null,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .delivery_options = "DeliveryOptions",
        .reputation_options = "ReputationOptions",
        .sending_options = "SendingOptions",
        .tags = "Tags",
        .tracking_options = "TrackingOptions",
    };
};

pub const CreateConfigurationSetOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConfigurationSetInput, options: CallOptions) !CreateConfigurationSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConfigurationSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "Pinpoint Email", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/email/configuration-sets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConfigurationSetName\":");
    try aws.json.writeValue(@TypeOf(input.configuration_set_name), input.configuration_set_name, allocator, &body_buf);
    has_prev = true;
    if (input.delivery_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeliveryOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.reputation_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReputationOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sending_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SendingOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tracking_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TrackingOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConfigurationSetOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CreateConfigurationSetOutput = .{};

    return result;
}
