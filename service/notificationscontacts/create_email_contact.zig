const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateEmailContactInput = struct {
    /// The email address this email contact points to. The activation email and any
    /// subscribed emails are sent here.
    ///
    /// This email address can't receive emails until it's activated.
    email_address: []const u8,

    /// The name of the email contact.
    name: []const u8,

    /// A map of tags assigned to a resource. A tag is a string-to-string map of
    /// key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .email_address = "emailAddress",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateEmailContactOutput = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEmailContactInput, options: CallOptions) !CreateEmailContactOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "notifications-contacts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEmailContactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications-contacts", "NotificationsContacts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2022-09-19/emailcontacts";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"emailAddress\":");
    try aws.json.writeValue(@TypeOf(input.email_address), input.email_address, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEmailContactOutput {
    const result: CreateEmailContactOutput = try aws.json.parseJsonObject(
        CreateEmailContactOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
