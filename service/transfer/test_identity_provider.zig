const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Protocol = @import("protocol.zig").Protocol;

pub const TestIdentityProviderInput = struct {
    /// A system-assigned identifier for a specific server. That server's user
    /// authentication method is tested with a user name and password.
    server_id: []const u8,

    /// The type of file transfer protocol to be tested.
    ///
    /// The available protocols are:
    ///
    /// * Secure Shell (SSH) File Transfer Protocol (SFTP)
    /// * File Transfer Protocol Secure (FTPS)
    /// * File Transfer Protocol (FTP)
    /// * Applicability Statement 2 (AS2)
    server_protocol: ?Protocol = null,

    /// The source IP address of the account to be tested.
    source_ip: ?[]const u8 = null,

    /// The name of the account to be tested.
    user_name: []const u8,

    /// The password of the account to be tested.
    user_password: ?[]const u8 = null,

    pub const json_field_names = .{
        .server_id = "ServerId",
        .server_protocol = "ServerProtocol",
        .source_ip = "SourceIp",
        .user_name = "UserName",
        .user_password = "UserPassword",
    };
};

pub const TestIdentityProviderOutput = struct {
    /// A message that indicates whether the test was successful or not.
    ///
    /// If an empty string is returned, the most likely cause is that the
    /// authentication failed due to an incorrect username or password.
    message: ?[]const u8 = null,

    /// The response that is returned from your API Gateway or your Lambda function.
    response: ?[]const u8 = null,

    /// The HTTP status code that is the response from your API Gateway or your
    /// Lambda function.
    status_code: ?i32 = null,

    /// The endpoint of the service used to authenticate a user.
    url: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .response = "Response",
        .status_code = "StatusCode",
        .url = "Url",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestIdentityProviderInput, options: CallOptions) !TestIdentityProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TestIdentityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.TestIdentityProvider");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestIdentityProviderOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(TestIdentityProviderOutput, body, allocator);
}
