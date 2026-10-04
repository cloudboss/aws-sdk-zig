const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const CreatePlatformEndpointInput = struct {
    /// For a list of attributes, see [
    /// `SetEndpointAttributes`
    /// ](https://docs.aws.amazon.com/sns/latest/api/API_SetEndpointAttributes.html).
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// Arbitrary user data to associate with the endpoint. Amazon SNS does not use
    /// this data. The
    /// data must be in UTF-8 format and less than 2KB.
    custom_user_data: ?[]const u8 = null,

    /// `PlatformApplicationArn` returned from CreatePlatformApplication is used to
    /// create a an endpoint.
    platform_application_arn: []const u8,

    /// Unique identifier created by the notification service for an app on a
    /// device. The
    /// specific name for Token will vary, depending on which notification service
    /// is being
    /// used. For example, when using APNS as the notification service, you need the
    /// device
    /// token. Alternatively, when using GCM (Firebase Cloud Messaging) or ADM, the
    /// device token
    /// equivalent is called the registration ID.
    token: []const u8,
};

pub const CreatePlatformEndpointOutput = struct {
    /// EndpointArn returned from CreateEndpoint action.
    endpoint_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePlatformEndpointInput, options: CallOptions) !CreatePlatformEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePlatformEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreatePlatformEndpoint&Version=2010-03-31");
    if (input.attributes) |entries| {
        for (entries, 0..) |entry, idx| {
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
    }
    if (input.custom_user_data) |v| {
        try body_buf.appendSlice(allocator, "&CustomUserData=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&PlatformApplicationArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.platform_application_arn);
    try body_buf.appendSlice(allocator, "&Token=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.token);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePlatformEndpointOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatePlatformEndpointResult")) break;
            },
            else => {},
        }
    }

    var result: CreatePlatformEndpointOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EndpointArn")) {
                    result.endpoint_arn = try allocator.dupe(u8, try reader.readElementText());
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
