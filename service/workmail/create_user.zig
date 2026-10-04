const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserRole = @import("user_role.zig").UserRole;

pub const CreateUserInput = struct {
    /// The display name for the new user.
    display_name: []const u8,

    /// The first name of the new user.
    first_name: ?[]const u8 = null,

    /// If this parameter is enabled, the user will be hidden from the address book.
    hidden_from_global_address_list: ?bool = null,

    /// User ID from the IAM Identity Center. If this parameter is empty it will be
    /// updated automatically when the user logs in for the first time to the
    /// mailbox associated with WorkMail.
    identity_provider_user_id: ?[]const u8 = null,

    /// The last name of the new user.
    last_name: ?[]const u8 = null,

    /// The name for the new user. WorkMail directory user names have a maximum
    /// length of 64. All others have a maximum length of 20.
    name: []const u8,

    /// The identifier of the organization for which the user is created.
    organization_id: []const u8,

    /// The password for the new user.
    password: ?[]const u8 = null,

    /// The role of the new user.
    ///
    /// You cannot pass *SYSTEM_USER* or *RESOURCE* role in a single request. When a
    /// user role is not selected, the default role of *USER* is selected.
    role: ?UserRole = null,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .first_name = "FirstName",
        .hidden_from_global_address_list = "HiddenFromGlobalAddressList",
        .identity_provider_user_id = "IdentityProviderUserId",
        .last_name = "LastName",
        .name = "Name",
        .organization_id = "OrganizationId",
        .password = "Password",
        .role = "Role",
    };
};

pub const CreateUserOutput = struct {
    /// The identifier for the new user.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .user_id = "UserId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserInput, options: CallOptions) !CreateUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.CreateUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUserOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateUserOutput, body, allocator);
}
