const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TlsPolicy = @import("tls_policy.zig").TlsPolicy;

pub const PutConfigurationSetDeliveryOptionsInput = struct {
    /// The name of the configuration set that you want to associate with a
    /// dedicated IP
    /// pool.
    configuration_set_name: []const u8,

    /// The name of the dedicated IP pool that you want to associate with the
    /// configuration
    /// set.
    sending_pool_name: ?[]const u8 = null,

    /// Specifies whether messages that use the configuration set are required to
    /// use
    /// Transport Layer Security (TLS). If the value is `Require`, messages are only
    /// delivered if a TLS connection can be established. If the value is
    /// `Optional`,
    /// messages can be delivered in plain text if a TLS connection can't be
    /// established.
    tls_policy: ?TlsPolicy = null,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .sending_pool_name = "SendingPoolName",
        .tls_policy = "TlsPolicy",
    };
};

pub const PutConfigurationSetDeliveryOptionsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutConfigurationSetDeliveryOptionsInput, options: CallOptions) !PutConfigurationSetDeliveryOptionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutConfigurationSetDeliveryOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "Pinpoint Email", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/email/configuration-sets/");
    try path_buf.appendSlice(allocator, input.configuration_set_name);
    try path_buf.appendSlice(allocator, "/delivery-options");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.sending_pool_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SendingPoolName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tls_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TlsPolicy\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutConfigurationSetDeliveryOptionsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutConfigurationSetDeliveryOptionsOutput = .{};

    return result;
}
