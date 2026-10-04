const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ChangePasswordInput = struct {
    /// A valid access token that Amazon Cognito issued to the user whose password
    /// you want to
    /// change.
    access_token: []const u8,

    /// The user's previous password. Required if the user has a password. If the
    /// user
    /// has no password and only signs in with passwordless authentication options,
    /// you can omit
    /// this parameter.
    previous_password: ?[]const u8 = null,

    /// A new password that you prompted the user to enter in your application.
    proposed_password: []const u8,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .previous_password = "PreviousPassword",
        .proposed_password = "ProposedPassword",
    };
};

pub const ChangePasswordOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ChangePasswordInput, options: CallOptions) !ChangePasswordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ChangePasswordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.ChangePassword");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ChangePasswordOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
