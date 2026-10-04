const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Profile = @import("profile.zig").Profile;

pub const CreateProfileInput = struct {
    /// `ClientToken` is an idempotency token that ensures a call to `CreateProfile`
    /// completes only once. You choose the value to pass.
    /// For example, an issue might prevent you from getting a response from
    /// `CreateProfile`.
    /// In this case, safely retry your call to `CreateProfile` by using the same
    /// `CreateProfile` parameter value.
    client_token: []const u8,

    /// A name for the Profile.
    name: []const u8,

    /// A list of the tag keys and values that you want to associate with the Route
    /// 53 Profile.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateProfileOutput = struct {
    /// The Profile that you just created.
    profile: ?Profile = null,

    pub const json_field_names = .{
        .profile = "Profile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProfileInput, options: CallOptions) !CreateProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53profiles", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53profiles", "Route53Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/profile";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProfileOutput {
    var result: CreateProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
