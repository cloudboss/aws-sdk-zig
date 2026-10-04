const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const GetEndpointAttributesInput = struct {
    /// `EndpointArn` for `GetEndpointAttributes` input.
    endpoint_arn: []const u8,
};

pub const GetEndpointAttributesOutput = struct {
    /// Attributes include the following:
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
    ///
    /// The device token for the iOS platform is returned in lowercase.
    attributes: ?[]const aws.map.StringMapEntry = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEndpointAttributesInput, options: CallOptions) !GetEndpointAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEndpointAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetEndpointAttributes&Version=2010-03-31");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEndpointAttributesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetEndpointAttributesResult")) break;
            },
            else => {},
        }
    }

    var result: GetEndpointAttributesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Attributes")) {
                    result.attributes = try serde.deserializeMapStringToString(allocator, &reader, "entry");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
