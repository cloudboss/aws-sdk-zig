const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProfileQuestionUpdate = @import("profile_question_update.zig").ProfileQuestionUpdate;
const Profile = @import("profile.zig").Profile;

pub const UpdateProfileInput = struct {
    /// The profile ARN.
    profile_arn: []const u8,

    /// The profile description.
    profile_description: ?[]const u8 = null,

    /// Profile questions.
    profile_questions: ?[]const ProfileQuestionUpdate = null,

    pub const json_field_names = .{
        .profile_arn = "ProfileArn",
        .profile_description = "ProfileDescription",
        .profile_questions = "ProfileQuestions",
    };
};

pub const UpdateProfileOutput = struct {
    /// The profile.
    profile: ?Profile = null,

    pub const json_field_names = .{
        .profile = "Profile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProfileInput, options: CallOptions) !UpdateProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/profiles/");
    try path_buf.appendSlice(allocator, input.profile_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.profile_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProfileDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.profile_questions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProfileQuestions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProfileOutput {
    var result: UpdateProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
