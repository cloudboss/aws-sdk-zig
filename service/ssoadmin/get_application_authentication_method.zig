const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationMethodType = @import("authentication_method_type.zig").AuthenticationMethodType;
const AuthenticationMethod = @import("authentication_method.zig").AuthenticationMethod;

pub const GetApplicationAuthenticationMethodInput = struct {
    /// Specifies the ARN of the application.
    application_arn: []const u8,

    /// Specifies the type of authentication method for which you want details.
    authentication_method_type: AuthenticationMethodType,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .authentication_method_type = "AuthenticationMethodType",
    };
};

pub const GetApplicationAuthenticationMethodOutput = struct {
    /// A structure that contains details about the requested authentication method.
    authentication_method: ?AuthenticationMethod = null,

    pub const json_field_names = .{
        .authentication_method = "AuthenticationMethod",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationAuthenticationMethodInput, options: CallOptions) !GetApplicationAuthenticationMethodOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApplicationAuthenticationMethodInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.GetApplicationAuthenticationMethod");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApplicationAuthenticationMethodOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetApplicationAuthenticationMethodOutput, body, allocator);
}
