const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProfileLimitValue = @import("profile_limit_value.zig").ProfileLimitValue;

pub const CreateLimitsProfileInput = struct {
    /// The ID of the Amazon Web Services account that contains the limits profile.
    account_id: []const u8,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, the service
    /// ignores the request, but does not return an error.
    client_token: []const u8,

    /// A description for the limits profile.
    description: ?[]const u8 = null,

    /// A display name for the limits profile.
    profile_name: []const u8,

    /// A map of resource types to their limit values for this profile.
    resource_limits: []const aws.map.MapEntry(ProfileLimitValue),

    pub const json_field_names = .{
        .account_id = "accountId",
        .client_token = "clientToken",
        .description = "description",
        .profile_name = "profileName",
        .resource_limits = "resourceLimits",
    };
};

pub const CreateLimitsProfileOutput = struct {
    /// The Amazon Resource Name (ARN) of the created limits profile.
    arn: []const u8,

    /// The unique identifier for the created limits profile.
    profile_id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .profile_id = "profileId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLimitsProfileInput, options: CallOptions) !CreateLimitsProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLimitsProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/governance/limits/accounts/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/profiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"profileName\":");
    try aws.json.writeValue(@TypeOf(input.profile_name), input.profile_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceLimits\":");
    try aws.json.writeValue(@TypeOf(input.resource_limits), input.resource_limits, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLimitsProfileOutput {
    const result: CreateLimitsProfileOutput = try aws.json.parseJsonObject(
        CreateLimitsProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
