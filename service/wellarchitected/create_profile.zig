const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProfileQuestionUpdate = @import("profile_question_update.zig").ProfileQuestionUpdate;

pub const CreateProfileInput = struct {
    client_request_token: []const u8,

    /// The profile description.
    profile_description: []const u8,

    /// Name of the profile.
    profile_name: []const u8,

    /// The profile questions.
    profile_questions: []const ProfileQuestionUpdate,

    /// The tags assigned to the profile.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .profile_description = "ProfileDescription",
        .profile_name = "ProfileName",
        .profile_questions = "ProfileQuestions",
        .tags = "Tags",
    };
};

pub const CreateProfileOutput = struct {
    /// The profile ARN.
    profile_arn: ?[]const u8 = null,

    /// Version of the profile.
    profile_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .profile_arn = "ProfileArn",
        .profile_version = "ProfileVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProfileInput, options: CallOptions) !CreateProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/profiles";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProfileDescription\":");
    try aws.json.writeValue(@TypeOf(input.profile_description), input.profile_description, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProfileName\":");
    try aws.json.writeValue(@TypeOf(input.profile_name), input.profile_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProfileQuestions\":");
    try aws.json.writeValue(@TypeOf(input.profile_questions), input.profile_questions, allocator, &body_buf);
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
