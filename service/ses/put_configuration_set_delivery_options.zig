const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeliveryOptions = @import("delivery_options.zig").DeliveryOptions;
const serde = @import("serde.zig");

pub const PutConfigurationSetDeliveryOptionsInput = struct {
    /// The name of the configuration set.
    configuration_set_name: []const u8,

    /// Specifies whether messages that use the configuration set are required to
    /// use
    /// Transport Layer Security (TLS).
    delivery_options: ?DeliveryOptions = null,
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
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PutConfigurationSetDeliveryOptions&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&ConfigurationSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.configuration_set_name);
    if (input.delivery_options) |v| {
        if (v.tls_policy) |sv| {
            try body_buf.appendSlice(allocator, "&DeliveryOptions.TlsPolicy=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutConfigurationSetDeliveryOptionsOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: PutConfigurationSetDeliveryOptionsOutput = .{};

    return result;
}
