const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateSoftwareTokenInput = struct {
    /// A valid access token that Amazon Cognito issued to the currently signed-in
    /// user. Must include a scope claim for
    /// `aws.cognito.signin.user.admin`.
    ///
    /// You can provide either an access token or a session ID in the request.
    access_token: ?[]const u8 = null,

    /// The session identifier that maintains the state of authentication requests
    /// and
    /// challenge responses. In `AssociateSoftwareToken`, this is the session ID
    /// from
    /// a successful sign-in. You can provide either an access token or a session ID
    /// in the
    /// request.
    session: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .session = "Session",
    };
};

pub const AssociateSoftwareTokenOutput = struct {
    /// A unique generated shared secret code that is used by the TOTP algorithm to
    /// generate a
    /// one-time code.
    secret_code: ?[]const u8 = null,

    /// The session identifier that maintains the state of authentication requests
    /// and
    /// challenge responses.
    session: ?[]const u8 = null,

    pub const json_field_names = .{
        .secret_code = "SecretCode",
        .session = "Session",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateSoftwareTokenInput, options: CallOptions) !AssociateSoftwareTokenOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateSoftwareTokenInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.AssociateSoftwareToken");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateSoftwareTokenOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AssociateSoftwareTokenOutput, body, allocator);
}
