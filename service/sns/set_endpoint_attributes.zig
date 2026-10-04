const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const SetEndpointAttributesInput = struct {
    /// A map of the endpoint attributes. Attributes in this map include the
    /// following:
    ///
    /// * `CustomUserData` – arbitrary user data to associate with the
    /// endpoint. Amazon SNS does not use this data. The data must be in UTF-8
    /// format and
    /// less than 2KB.
    ///
    /// * `Enabled` – flag that enables/disables delivery to the
    /// endpoint. Amazon SNS will set this to false when a notification service
    /// indicates to
    /// Amazon SNS that the endpoint is invalid. Users can set it back to true,
    /// typically
    /// after updating Token.
    ///
    /// * `Token` – device token, also referred to as a registration id,
    /// for an app and mobile device. This is returned from the notification service
    /// when an app and mobile device are registered with the notification
    /// service.
    attributes: []const aws.map.StringMapEntry,

    /// EndpointArn used for `SetEndpointAttributes` action.
    endpoint_arn: []const u8,
};

pub const SetEndpointAttributesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetEndpointAttributesInput, options: CallOptions) !SetEndpointAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetEndpointAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetEndpointAttributes&Version=2010-03-31");
    for (input.attributes, 0..) |entry, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const key_prefix = std.fmt.bufPrint(&prefix_buf, "&Attributes.entry.{d}.key=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, key_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, entry.key);
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const val_prefix = std.fmt.bufPrint(&prefix_buf, "&Attributes.entry.{d}.value=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, val_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, entry.value);
        }
    }
    try body_buf.appendSlice(allocator, "&EndpointArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.endpoint_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetEndpointAttributesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetEndpointAttributesOutput = .{};

    return result;
}
