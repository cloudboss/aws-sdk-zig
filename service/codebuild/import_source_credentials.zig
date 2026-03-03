const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AuthType = @import("auth_type.zig").AuthType;
const ServerType = @import("server_type.zig").ServerType;

pub const ImportSourceCredentialsInput = struct {
    /// The type of authentication used to connect to a GitHub, GitHub Enterprise,
    /// GitLab, GitLab Self Managed, or
    /// Bitbucket repository. An OAUTH connection is not supported by the API and
    /// must be
    /// created using the CodeBuild console.
    auth_type: AuthType,

    /// The source provider used for this project.
    server_type: ServerType,

    /// Set to `false` to prevent overwriting the repository source credentials.
    /// Set to `true` to overwrite the repository source credentials. The default
    /// value is `true`.
    should_overwrite: ?bool = null,

    /// For GitHub or GitHub Enterprise, this is the personal access token. For
    /// Bitbucket,
    /// this is either the access token or the app password. For the `authType`
    /// CODECONNECTIONS,
    /// this is the `connectionArn`. For the `authType` SECRETS_MANAGER, this is the
    /// `secretArn`.
    token: []const u8,

    /// The Bitbucket username when the `authType` is BASIC_AUTH. This parameter
    /// is not valid for other types of source providers or connections.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_type = "authType",
        .server_type = "serverType",
        .should_overwrite = "shouldOverwrite",
        .token = "token",
        .username = "username",
    };
};

pub const ImportSourceCredentialsOutput = struct {
    /// The Amazon Resource Name (ARN) of the token.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportSourceCredentialsInput, options: Options) !ImportSourceCredentialsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codebuild");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportSourceCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.ImportSourceCredentials");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportSourceCredentialsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportSourceCredentialsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccountLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .account_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountSuspendedException")) {
        return .{ .arena = arena, .kind = .{ .account_suspended_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OAuthProviderException")) {
        return .{ .arena = arena, .kind = .{ .o_auth_provider_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
