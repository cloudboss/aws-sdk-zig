const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationMethod = @import("authentication_method.zig").AuthenticationMethod;
const AuthenticationMethodType = @import("authentication_method_type.zig").AuthenticationMethodType;

pub const PutApplicationAuthenticationMethodInput = struct {
    /// Specifies the ARN of the application with the authentication method to add
    /// or update.
    application_arn: []const u8,

    /// Specifies a structure that describes the authentication method to add or
    /// update. The structure type you provide is determined by the
    /// `AuthenticationMethodType` parameter.
    authentication_method: AuthenticationMethod,

    /// Specifies the type of the authentication method that you want to add or
    /// update.
    authentication_method_type: AuthenticationMethodType,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .authentication_method = "AuthenticationMethod",
        .authentication_method_type = "AuthenticationMethodType",
    };
};

pub const PutApplicationAuthenticationMethodOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutApplicationAuthenticationMethodInput, options: CallOptions) !PutApplicationAuthenticationMethodOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sso", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutApplicationAuthenticationMethodInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sso", "SSO Admin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.PutApplicationAuthenticationMethod");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutApplicationAuthenticationMethodOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
