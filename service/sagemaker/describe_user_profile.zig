const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const UserProfileStatus = @import("user_profile_status.zig").UserProfileStatus;
const UserSettings = @import("user_settings.zig").UserSettings;

pub const DescribeUserProfileInput = struct {
    /// The domain ID.
    domain_id: []const u8,

    /// The user profile name. This value is not case sensitive.
    user_profile_name: []const u8,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .user_profile_name = "UserProfileName",
    };
};

pub const DescribeUserProfileOutput = struct {
    /// The creation time.
    creation_time: ?i64 = null,

    /// The ID of the domain that contains the profile.
    domain_id: ?[]const u8 = null,

    /// The failure reason.
    failure_reason: ?[]const u8 = null,

    /// The ID of the user's profile in the Amazon Elastic File System volume.
    home_efs_file_system_uid: ?[]const u8 = null,

    /// The last modified time.
    last_modified_time: ?i64 = null,

    /// The IAM Identity Center user identifier.
    single_sign_on_user_identifier: ?[]const u8 = null,

    /// The IAM Identity Center user value.
    single_sign_on_user_value: ?[]const u8 = null,

    /// The status.
    status: ?UserProfileStatus = null,

    /// The user profile Amazon Resource Name (ARN).
    user_profile_arn: ?[]const u8 = null,

    /// The user profile name.
    user_profile_name: ?[]const u8 = null,

    /// A collection of settings.
    user_settings: ?UserSettings = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .domain_id = "DomainId",
        .failure_reason = "FailureReason",
        .home_efs_file_system_uid = "HomeEfsFileSystemUid",
        .last_modified_time = "LastModifiedTime",
        .single_sign_on_user_identifier = "SingleSignOnUserIdentifier",
        .single_sign_on_user_value = "SingleSignOnUserValue",
        .status = "Status",
        .user_profile_arn = "UserProfileArn",
        .user_profile_name = "UserProfileName",
        .user_settings = "UserSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeUserProfileInput, options: CallOptions) !DescribeUserProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeUserProfileInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeUserProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeUserProfileOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeUserProfileOutput, body, allocator);
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
