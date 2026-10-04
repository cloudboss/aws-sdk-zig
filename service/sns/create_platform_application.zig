const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const CreatePlatformApplicationInput = struct {
    /// For a list of attributes, see [
    /// `SetPlatformApplicationAttributes`
    /// ](https://docs.aws.amazon.com/sns/latest/api/API_SetPlatformApplicationAttributes.html).
    attributes: []const aws.map.StringMapEntry,

    /// Application names must be made up of only uppercase and lowercase ASCII
    /// letters,
    /// numbers, underscores, hyphens, and periods, and must be between 1 and 256
    /// characters
    /// long.
    name: []const u8,

    /// The following platforms are supported: ADM (Amazon Device Messaging), APNS
    /// (Apple Push
    /// Notification Service), APNS_SANDBOX, and GCM (Firebase Cloud Messaging).
    platform: []const u8,
};

pub const CreatePlatformApplicationOutput = struct {
    /// `PlatformApplicationArn` is returned.
    platform_application_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePlatformApplicationInput, options: CallOptions) !CreatePlatformApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePlatformApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreatePlatformApplication&Version=2010-03-31");
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
    try body_buf.appendSlice(allocator, "&Name=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "&Platform=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.platform);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePlatformApplicationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatePlatformApplicationResult")) break;
            },
            else => {},
        }
    }

    var result: CreatePlatformApplicationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PlatformApplicationArn")) {
                    result.platform_application_arn = try allocator.dupe(u8, try reader.readElementText());
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
