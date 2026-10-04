const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExpirationSettings = @import("expiration_settings.zig").ExpirationSettings;
const Tag = @import("tag.zig").Tag;

pub const CreateAppInstanceUserInput = struct {
    /// The ARN of the `AppInstance` request.
    app_instance_arn: []const u8,

    /// The user ID of the `AppInstance`.
    app_instance_user_id: []const u8,

    /// The unique ID of the request. Use different tokens to request additional
    /// `AppInstances`.
    client_request_token: []const u8,

    /// Settings that control the interval after which the `AppInstanceUser` is
    /// automatically deleted.
    expiration_settings: ?ExpirationSettings = null,

    /// The request's metadata. Limited to a 1KB string in UTF-8.
    metadata: ?[]const u8 = null,

    /// The user's name.
    name: []const u8,

    /// Tags assigned to the `AppInstanceUser`.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .app_instance_arn = "AppInstanceArn",
        .app_instance_user_id = "AppInstanceUserId",
        .client_request_token = "ClientRequestToken",
        .expiration_settings = "ExpirationSettings",
        .metadata = "Metadata",
        .name = "Name",
        .tags = "Tags",
    };
};

pub const CreateAppInstanceUserOutput = struct {
    /// The user's ARN.
    app_instance_user_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_instance_user_arn = "AppInstanceUserArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAppInstanceUserInput, options: CallOptions) !CreateAppInstanceUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAppInstanceUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("identity-chime", "Chime SDK Identity", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/app-instance-users";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AppInstanceArn\":");
    try aws.json.writeValue(@TypeOf(input.app_instance_arn), input.app_instance_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AppInstanceUserId\":");
    try aws.json.writeValue(@TypeOf(input.app_instance_user_id), input.app_instance_user_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (input.expiration_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExpirationSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Metadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAppInstanceUserOutput {
    var result: CreateAppInstanceUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAppInstanceUserOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
