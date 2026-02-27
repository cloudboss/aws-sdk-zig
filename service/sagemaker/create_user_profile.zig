const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const UserSettings = @import("user_settings.zig").UserSettings;

pub const CreateUserProfileInput = struct {
    /// The ID of the associated Domain.
    domain_id: []const u8,

    /// A specifier for the type of value specified in SingleSignOnUserValue.
    /// Currently, the only supported value is "UserName". If the Domain's AuthMode
    /// is IAM Identity Center, this field is required. If the Domain's AuthMode is
    /// not IAM Identity Center, this field cannot be specified.
    single_sign_on_user_identifier: ?[]const u8 = null,

    /// The username of the associated Amazon Web Services Single Sign-On User for
    /// this UserProfile. If the Domain's AuthMode is IAM Identity Center, this
    /// field is required, and must match a valid username of a user in your
    /// directory. If the Domain's AuthMode is not IAM Identity Center, this field
    /// cannot be specified.
    single_sign_on_user_value: ?[]const u8 = null,

    /// Each tag consists of a key and an optional value. Tag keys must be unique
    /// per resource.
    ///
    /// Tags that you specify for the User Profile are also added to all Apps that
    /// the User Profile launches.
    tags: ?[]const Tag = null,

    /// A name for the UserProfile. This value is not case sensitive.
    user_profile_name: []const u8,

    /// A collection of settings.
    user_settings: ?UserSettings = null,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .single_sign_on_user_identifier = "SingleSignOnUserIdentifier",
        .single_sign_on_user_value = "SingleSignOnUserValue",
        .tags = "Tags",
        .user_profile_name = "UserProfileName",
        .user_settings = "UserSettings",
    };
};

pub const CreateUserProfileOutput = struct {
    /// The user profile Amazon Resource Name (ARN).
    user_profile_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .user_profile_arn = "UserProfileArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserProfileInput, options: Options) !CreateUserProfileOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateUserProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.CreateUserProfile");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateUserProfileOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateUserProfileOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
