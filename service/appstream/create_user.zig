const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const MessageAction = @import("message_action.zig").MessageAction;

pub const CreateUserInput = struct {
    /// The authentication type for the user. You must specify USERPOOL.
    authentication_type: AuthenticationType,

    /// The first name, or given name, of the user.
    first_name: ?[]const u8 = null,

    /// The last name, or surname, of the user.
    last_name: ?[]const u8 = null,

    /// The action to take for the welcome email that is sent to a user after the
    /// user is created in the user pool. If you specify SUPPRESS, no email is sent.
    /// If you specify RESEND, do not specify the first name or last name of the
    /// user. If the value is null, the email is sent.
    ///
    /// The temporary password in the welcome email is valid for only 7 days. If
    /// users don’t set their passwords within 7 days, you must send them a new
    /// welcome email.
    message_action: ?MessageAction = null,

    /// The email address of the user.
    ///
    /// Users' email addresses are case-sensitive. During login, if they specify an
    /// email address that doesn't use the same capitalization as the email address
    /// specified when their user pool account was created, a "user does not exist"
    /// error message displays.
    user_name: []const u8,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .first_name = "FirstName",
        .last_name = "LastName",
        .message_action = "MessageAction",
        .user_name = "UserName",
    };
};

pub const CreateUserOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserInput, options: CallOptions) !CreateUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CreateUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUserOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
