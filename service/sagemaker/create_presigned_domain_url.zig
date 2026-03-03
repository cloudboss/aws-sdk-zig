const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const CreatePresignedDomainUrlInput = struct {
    /// The domain ID.
    domain_id: []const u8,

    /// The number of seconds until the pre-signed URL expires. This value defaults
    /// to 300.
    expires_in_seconds: ?i32 = null,

    /// The landing page that the user is directed to when accessing the presigned
    /// URL. Using this value, users can access Studio or Studio Classic, even if it
    /// is not the default experience for the domain. The supported values are:
    ///
    /// * `studio::relative/path`: Directs users to the relative path in Studio.
    /// * `app:JupyterServer:relative/path`: Directs users to the relative path in
    ///   the Studio Classic application.
    /// * `app:JupyterLab:relative/path`: Directs users to the relative path in the
    ///   JupyterLab application.
    /// * `app:RStudioServerPro:relative/path`: Directs users to the relative path
    ///   in the RStudio application.
    /// * `app:CodeEditor:relative/path`: Directs users to the relative path in the
    ///   Code Editor, based on Code-OSS, Visual Studio Code - Open Source
    ///   application.
    /// * `app:Canvas:relative/path`: Directs users to the relative path in the
    ///   Canvas application.
    landing_uri: ?[]const u8 = null,

    /// The session expiration duration in seconds. This value defaults to 43200.
    session_expiration_duration_in_seconds: ?i32 = null,

    /// The name of the space.
    space_name: ?[]const u8 = null,

    /// The name of the UserProfile to sign-in as.
    user_profile_name: []const u8,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .expires_in_seconds = "ExpiresInSeconds",
        .landing_uri = "LandingUri",
        .session_expiration_duration_in_seconds = "SessionExpirationDurationInSeconds",
        .space_name = "SpaceName",
        .user_profile_name = "UserProfileName",
    };
};

pub const CreatePresignedDomainUrlOutput = struct {
    /// The presigned URL.
    authorized_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorized_url = "AuthorizedUrl",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePresignedDomainUrlInput, options: Options) !CreatePresignedDomainUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePresignedDomainUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreatePresignedDomainUrl");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePresignedDomainUrlOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreatePresignedDomainUrlOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
