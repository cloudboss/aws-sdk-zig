const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateAnonymousWebExperienceUrlInput = struct {
    /// The identifier of the Amazon Q Business application environment attached to
    /// the web experience.
    application_id: []const u8,

    /// The duration of the session associated with the unique URL for the web
    /// experience.
    session_duration_in_minutes: ?i32 = null,

    /// The identifier of the web experience.
    web_experience_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .session_duration_in_minutes = "sessionDurationInMinutes",
        .web_experience_id = "webExperienceId",
    };
};

pub const CreateAnonymousWebExperienceUrlOutput = struct {
    /// The unique URL for accessing the web experience.
    ///
    /// This URL can only be used once and must be used within 5 minutes after it's
    /// generated.
    anonymous_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .anonymous_url = "anonymousUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAnonymousWebExperienceUrlInput, options: CallOptions) !CreateAnonymousWebExperienceUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAnonymousWebExperienceUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/experiences/");
    try path_buf.appendSlice(allocator, input.web_experience_id);
    try path_buf.appendSlice(allocator, "/anonymous-url");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.session_duration_in_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionDurationInMinutes\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAnonymousWebExperienceUrlOutput {
    const result: CreateAnonymousWebExperienceUrlOutput = try aws.json.parseJsonObject(
        CreateAnonymousWebExperienceUrlOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
