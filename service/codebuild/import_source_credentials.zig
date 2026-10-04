const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportSourceCredentialsInput, options: CallOptions) !ImportSourceCredentialsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codebuild", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportSourceCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
