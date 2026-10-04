const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StorageRuleType = @import("storage_rule_type.zig").StorageRuleType;
const User = @import("user.zig").User;

pub const CreateUserInput = struct {
    /// Amazon WorkDocs authentication token. Not required when using Amazon Web
    /// Services administrator credentials to access the API.
    authentication_token: ?[]const u8 = null,

    /// The email address of the user.
    email_address: ?[]const u8 = null,

    /// The given name of the user.
    given_name: []const u8,

    /// The ID of the organization.
    organization_id: ?[]const u8 = null,

    /// The password of the user.
    password: []const u8,

    /// The amount of storage for the user.
    storage_rule: ?StorageRuleType = null,

    /// The surname of the user.
    surname: []const u8,

    /// The time zone ID of the user.
    time_zone_id: ?[]const u8 = null,

    /// The login name of the user.
    username: []const u8,

    pub const json_field_names = .{
        .authentication_token = "AuthenticationToken",
        .email_address = "EmailAddress",
        .given_name = "GivenName",
        .organization_id = "OrganizationId",
        .password = "Password",
        .storage_rule = "StorageRule",
        .surname = "Surname",
        .time_zone_id = "TimeZoneId",
        .username = "Username",
    };
};

pub const CreateUserOutput = struct {
    /// The user information.
    user: ?User = null,

    pub const json_field_names = .{
        .user = "User",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserInput, options: CallOptions) !CreateUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workdocs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workdocs", "WorkDocs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/api/v1/users";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.email_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EmailAddress\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GivenName\":");
    try aws.json.writeValue(@TypeOf(input.given_name), input.given_name, allocator, &body_buf);
    has_prev = true;
    if (input.organization_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OrganizationId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Password\":");
    try aws.json.writeValue(@TypeOf(input.password), input.password, allocator, &body_buf);
    has_prev = true;
    if (input.storage_rule) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StorageRule\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Surname\":");
    try aws.json.writeValue(@TypeOf(input.surname), input.surname, allocator, &body_buf);
    has_prev = true;
    if (input.time_zone_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TimeZoneId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Username\":");
    try aws.json.writeValue(@TypeOf(input.username), input.username, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.authentication_token) |v| {
        try request.headers.put(allocator, "Authentication", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUserOutput {
    const result: CreateUserOutput = try aws.json.parseJsonObject(
        CreateUserOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
