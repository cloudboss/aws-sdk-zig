const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserSettings = @import("user_settings.zig").UserSettings;

pub const UpdateUserProfileInput = struct {
    /// The domain ID.
    domain_id: []const u8,

    /// The user profile name.
    user_profile_name: []const u8,

    /// A collection of settings.
    user_settings: ?UserSettings = null,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .user_profile_name = "UserProfileName",
        .user_settings = "UserSettings",
    };
};

pub const UpdateUserProfileOutput = struct {
    /// The user profile Amazon Resource Name (ARN).
    user_profile_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .user_profile_arn = "UserProfileArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserProfileInput, options: CallOptions) !UpdateUserProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateUserProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserProfileOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateUserProfileOutput, body, allocator);
}
